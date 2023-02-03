page 50102 "Sales Order Templ. List"
{
    ApplicationArea = All;
    Caption = 'Sales Order Templ. List';
    PageType = List;
    SourceTable = "Sales Order Templ.";
    UsageCategory = Lists;
    CardPageId = "Sales Order Templ. Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
