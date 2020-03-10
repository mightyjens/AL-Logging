page 50102 "Logging API"
{
    PageType = API;
    Caption = 'LogEntry';
    APIPublisher = 'Comsol';
    APIGroup = 'ComsolLogging';
    APIVersion = 'beta';
    EntityName = 'LogEntry';
    EntitySetName = 'ComsolLogging';
    SourceTable = "Logging Entries";
    DelayedInsert = true;
    ODataKeyFields = Id;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Id)
                {
                    ApplicationArea = All;
                }
                field(No; "No.")
                {
                    ApplicationArea = All;
                }
                field(LogType; "Log Type")
                {
                    ApplicationArea = All;
                }
                field(LogMessage; "Log Message")
                {
                    ApplicationArea = All;
                }
                field(LogUser; "Log User")
                {
                    ApplicationArea = All;
                }
                field(LogPayload; "Log Payload")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Insert(true);

        Modify(true);
        exit(false);
    end;
}