table 50100 "Logging Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Company Id"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; User; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Password; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Http Method"; Option)
        {
            OptionMembers = http,https;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    procedure GetSetup()
    var
        Setup: Record "Logging Setup";
        LoggingMgt: Codeunit "Logging Management";
    begin
        if setup.IsEmpty then begin
            Setup.Init();
            Setup.Insert(true);

            //Get company id
            Setup."Company Id" := LoggingMgt.GetCompanyId();
            Setup.Modify();
        end;

        Get;
    end;

    procedure GetApiEndpoint(): Text
    begin
        //Modify Publisher and Entity
        exit(StrSubstNo('%1://localhost:7048/BC/api/Comsol/ComsolLogging/beta', Format("Http Method")));
    end;

}