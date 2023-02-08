tableextension 50100 "Sales & Recievables Setup Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Sales Order Template"; Boolean)
        {
            Caption = 'Sales Order Template';
            DataClassification = CustomerContent;
        }
    }
}
