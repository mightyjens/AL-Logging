pageextension 50102 "Logging Extension" extends "Customer List"
{
    actions
    {
        addlast(Processing)
        {
            action(Logging)
            {
                ApplicationArea = ALL;
                Caption = 'Log Message';
                Image = Log;
                Promoted = true;

                trigger OnAction()
                var
                    LoggingManagement: Codeunit "Logging Management";
                begin
                    Page.Run(50101);
                end;
            }
        }
    }
}