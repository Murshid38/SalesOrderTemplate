page 50100 "Select Sales Order Templ. List"
{
    ApplicationArea = All;
    Caption = 'Select a template for a new sales order';
    PageType = List;
    SourceTable = "Sales Order Templ.";
    UsageCategory = Lists;

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
