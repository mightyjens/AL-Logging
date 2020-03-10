page 50101 "Logging Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Logging Entries";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Log DateTime"; "Log DateTime")
                {
                    ApplicationArea = All;
                }
                field("Log Type"; "Log Type")
                {
                    ApplicationArea = All;
                }
                field("Log Message"; "Log Message")
                {
                    ApplicationArea = All;
                }
                field("Log User"; "Log User")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LogEntry)
            {
                ApplicationArea = All;
                trigger OnAction();
                var
                    LogMgt: Codeunit "Logging Management";
                begin
                    LogMgt.CreateLogEntry(0, 'Test 123');
                end;
            }
            action(LogSetup)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    page.Run(50100);
                end;
            }
        }
    }
}