page 50101 "Sales Order Templ. Card"
{
    Caption = 'Sales Order Template';
    PageType = Card;
    SourceTable = "Sales Order Templ.";

    layout
    {
        area(content)
        {
            group(General)
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
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting No. Series field.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Your Reference field.';
                }
            }

            part(SalesTemplateLineSubform; "Sales Template Line Subform")
            {
                SubPageLink = "Template Code" = field(Code);
                ApplicationArea = all;
                UpdatePropagation = Both;//update subform and card in realtime
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Amount")
            {
                ApplicationArea = All;
                Image = ShowList;

                trigger OnAction()
                var
                    SalesTemplateLine: Record "Sales Order Template Line";
                begin
                    // SalesTemplateLine.FindFirst();
                    SalesTemplateLine.Get('SOTEMP01', 40000);
                    Message('%1', SalesTemplateLine.Quantity);
                end;
            }
        }
    }
}
