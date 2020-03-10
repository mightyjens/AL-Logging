page 50100 "Logging Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Logging Setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Company Id"; "Company Id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Http Method"; "Http Method")
                {
                    ApplicationArea = All;
                }
                field(User; User)
                {
                    ApplicationArea = All;
                }
                field(Password; Password)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}