table 50100 "Sales Order Templ."
{
    Caption = 'Sales Order Templ.';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        // field(4; "Posting No. Series"; Code[20])
        // {
        //     Caption = 'Posting No. Series';
        //     DataClassification = CustomerContent;
        //     TableRelation = "No. Series";
        // }
        field(5; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
