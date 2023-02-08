table 50101 "Sales Order Template Line"
{
    Caption = 'Sales Order Template Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Template Code"; Code[20])
        {
            Caption = 'Template Code';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Type"; Enum "Sales Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;

            TableRelation = if (Type = const("G/L Account")) "G/L Account"."No." where("Direct Posting" = const(true)) else
            if (Type = const(Item)) Item."No." else
            if (Type = const(Resource)) Resource."No." else
            if (Type = const("Fixed Asset")) "Fixed Asset"."No." else
            if (Type = const("Charge (Item)")) "Item Charge";

            trigger OnValidate()
            begin
                case Type of
                    Type::"G/L Account":
                        if GLAccount.Get("No.") then
                            Description := GLAccount.Name;
                    Type::Item:
                        if Item.Get("No.") then
                            Description := Item.Description;
                    Type::Resource:
                        if Resource.Get("No.") then
                            Description := Resource.Name;
                    Type::"Fixed Asset":
                        if FixedAsset.Get("No.") then
                            Description := FixedAsset.Description;
                    Type::"Charge (Item)":
                        if ItemCharge.Get("No.") then
                            Description := ItemCharge.Description;
                end;
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
    }


    keys
    {
        key(PK; "Template Code", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        GLAccount: Record "G/L Account";
        Item: Record Item;
        FixedAsset: Record "Fixed Asset";
        Resource: Record Resource;
        ItemCharge: Record "Item Charge";
}
