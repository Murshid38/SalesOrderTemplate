pageextension 50100 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Action3)
        {
            action(New)
            {
                ApplicationArea = All;
                Image = New;

                trigger OnAction()
                begin
                    CreateSalesOrderFromTemplate();
                end;
            }
        }
    }


    procedure CreateSalesOrderFromTemplate() Result: Boolean
    var
        SalesOrderTempl: Record "Sales Order Templ.";
    begin
        if not SelectSalesOrderTemplate(SalesOrderTempl) then
            exit(false);

        Rec.Init();
        InitSalesOrderNo(SalesOrderTempl);
        Rec.Insert(true);

        exit(true);
    end;

    procedure InitSalesOrderNo(SalesOrderTempl: Record "Sales Order Templ.")
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if SalesOrderTempl."No. Series" = '' then
            exit;

        NoSeriesManagement.InitSeries(SalesOrderTempl."No. Series", '', 0D, Rec."No.", Rec."No. Series");
    end;

    procedure SelectSalesOrderTemplate(var SalesOrderTempl: Record "Sales Order Templ.") Result: Boolean
    var
        SelectSalesOrderTemplList: Page "Select Sales Order Templ. List";
        IsHandled: Boolean;
    begin

        if SalesOrderTempl.Count = 1 then begin
            SalesOrderTempl.FindFirst();
            exit(true);
        end;

        if (SalesOrderTempl.Count > 1) and GuiAllowed then begin
            SelectSalesOrderTemplList.SetTableView(SalesOrderTempl);
            SelectSalesOrderTemplList.LookupMode(true);
            if SelectSalesOrderTemplList.RunModal() = Action::LookupOK then begin
                SelectSalesOrderTemplList.GetRecord(SalesOrderTempl);
                exit(true);
            end;
        end;

        exit(false);
    end;

    // procedure SetInsertFromTemplate(FromTemplate: Boolean) begin
    //     InsertFromTemplate := FromTemplate;
    // end;

    // var
    //     InsertFromTemplate: Boolean;

}