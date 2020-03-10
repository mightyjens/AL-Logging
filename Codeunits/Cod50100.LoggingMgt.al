codeunit 50100 "Logging Management"
{
    procedure CreateLogEntry(LogType: Option error,info; LogMessage: Text[250]): Boolean
    var
        LoggingSetup: Record "Logging Setup";

        WebClient: HttpClient;
        RequestHeader: HttpHeaders;
        RequestContentHeader: HttpHeaders;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;

        ResponseText: Text;
        JObject: JsonObject;
        JToken: JsonToken;
    begin
        LoggingSetup.GetSetup();

        CreateWebRequest(LoggingSetup, RequestHeader, RequestMessage, 'POST');
        RequestMessage.SetRequestUri(StrSubstNo('%1/companies(%2)/ComsolLogging', LoggingSetup.GetApiEndpoint(), LoggingSetup."Company Id"));

        //Add Content
        RequestContent.WriteFrom(CreateLogPayload(LogType, LogMessage));
        RequestContent.GetHeaders(RequestContentHeader);
        RequestContentHeader.Remove('Content-Type');
        RequestContentHeader.Add('Content-Type', 'application/json; charset=utf-8');
        RequestMessage.Content(RequestContent);

        WebClient.Send(RequestMessage, ResponseMessage);

        //Debug
        if ResponseMessage.IsSuccessStatusCode then begin
            ResponseMessage.Content.ReadAs(ResponseText);
            JObject.ReadFrom(ResponseText);

            if JObject.Get('id', JToken) then
                exit(ResponseMessage.IsSuccessStatusCode and (JToken.AsValue().AsText() <> ''));
        end;

        exit(ResponseMessage.IsSuccessStatusCode);
    end;

    procedure GetCompanyId(): Text
    var
        LoggingSetup: Record "Logging Setup";

        WebClient: HttpClient;
        RequestHeader: HttpHeaders;
        RequestContentHeader: HttpHeaders;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;

        ResponseText: Text;
        JObject: JsonObject;
        JToken: JsonToken;
    begin
        LoggingSetup.GetSetup();

        CreateWebRequest(LoggingSetup, RequestHeader, RequestMessage, 'GET');
        RequestMessage.SetRequestUri(StrSubstNo('%1/companies(name=''%2'')', LoggingSetup.GetApiEndpoint(), CompanyName));

        WebClient.Send(RequestMessage, ResponseMessage);

        if ResponseMessage.IsSuccessStatusCode then begin
            ResponseMessage.Content.ReadAs(ResponseText);
            JObject.ReadFrom(ResponseText);

            if JObject.Get('id', JToken) then
                exit(JToken.AsValue().AsText())
            else
                Error('Company not found!');
        end;
    end;

    local procedure CreateWebRequest(LoggingSetup: Record "Logging Setup"; var pRequestHeader: HttpHeaders; var pRequestMessage: HttpRequestMessage; pMethod: Text)
    begin
        //Request Header
        pRequestMessage.GetHeaders(pRequestHeader);
        pRequestHeader.Add('Authorization', StrSubstNo('Basic %1', GetAuthorizationBase64(LoggingSetup)));
        pRequestMessage.Method(pMethod);
    end;

    local procedure GetAuthorizationBase64(LoggingSetup: Record "Logging Setup"): Text
    var
        TempBlob: Record TempBlob;
        Auth: Text;
    begin
        LoggingSetup.TestField(User);
        LoggingSetup.TestField(Password);

        Auth := StrSubstNo('%1:%2', LoggingSetup.User, LoggingSetup.Password);
        TempBlob.WriteAsText(Auth, TextEncoding::Windows);

        exit(TempBlob.ToBase64String());
    end;


    local procedure CreateLogPayload(LogType: Option error,info; Message: Text[250]): Text
    var
        RequestJson: JsonObject;
        RequestJsonText: Text;
    begin
        RequestJson.Add('LogType', Format(LogType));
        RequestJson.Add('LogMessage', Message);
        RequestJson.Add('LogUser', UserId);
        RequestJson.WriteTo(RequestJsonText);

        exit(RequestJsonText);
    end;
}