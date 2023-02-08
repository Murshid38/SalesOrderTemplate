pageextension 50103 "Sales " extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Document Default Line Type")
        {
            field("Sales Order Template"; Rec."Sales Order Template")
            {
                ApplicationArea = All;
            }
        }
    }
}
