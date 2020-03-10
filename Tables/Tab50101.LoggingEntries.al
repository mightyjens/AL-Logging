table 50101 "Logging Entries"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(5; "Log DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Log Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = error,info;
        }
        field(15; "Log User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Log Message"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Log Payload"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(100; Id; Guid)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {

        }
        key(ClusteredKey; "Log User")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        id := CreateGuid();
        "Log DateTime" := CurrentDateTime();
    end;

}