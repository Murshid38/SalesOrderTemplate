page 50105 "Select Sell To Customer"
{
    Caption = 'Standard Dialog Test';
    PageType = StandardDialog;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            field(SellToCustomerNo; SellToCustomerNo)
            {
                ApplicationArea = all;
                Caption = 'Select the Sell-to-customer';
                TableRelation = Customer;
            }
        }
    }

    procedure GetSellToCustomer(): Code[20]
    begin
        exit(SellToCustomerNo);
    end;

    var
        SellToCustomerNo: Code[20];
}