pageextension 50101 "Sales Order Ext" extends "Sales Order"
{
    local procedure CreateSalesOrderFromTemplate()
    begin
        if not NewMode then
            exit;
        NewMode := false;

        if InsertSalesOrderFromTemplate(Rec) then begin
            CurrPage.Update();

        end else
            CurrPage.Close;
    end;


    procedure SelectSalesOrderTemplate(var SalesOrderTempl: Record "Sales Order Templ.") Result: Boolean
    var
        SelectSalesOrderTemplList: Page "Select Sales Order Templ. List";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit(Result);

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

    procedure InsertSalesOrderFromTemplate(var SalesHeader: Record "Sales Header") Result: Boolean
    var
        SalesOrderTempl: Record "Sales Order Templ.";
        SalesOrderTemplLine: Record "Sales Order Template Line";
        SalesLine: Record "Sales Line";
    begin
        if not SelectSalesOrderTemplate(SalesOrderTempl) then
            exit(false);

        if SalesOrderTempl.Get(SalesOrderTempl.Code) then begin
            Rec.Init();
            InitSalesOrderNo(Rec, SalesOrderTempl);
            InitSalesOrderPostingNo(Rec, SalesOrderTempl);
            Rec."Document Type" := Rec."Document Type"::Order;
            Rec.Validate("Sell-to Customer No.", '30000');
            Rec."Your Reference" := SalesOrderTempl."Your Reference";
            Rec.Insert(true);

            SalesOrderTemplLine.SetRange("Template Code", SalesOrderTempl.Code);
            SalesOrderTemplLine.FindSet();
            repeat
                SalesLine.Init();
                SalesLine."Document Type" := Rec."Document Type"::Order;
                SalesLine."Document No." := Rec."No.";
                SalesLine."Line No." := SalesOrderTemplLine."Line No.";
                SalesLine.Validate(Type, SalesOrderTemplLine.Type);
                SalesLine.Validate("No.", SalesOrderTemplLine."No.");
                SalesLine.Validate(Quantity, SalesOrderTemplLine.Quantity);
                SalesLine.Insert(true);
            until SalesOrderTemplLine.Next() = 0;
        end;

        CurrPage.Close();
        Page.Run(42, Rec);

        exit(true);

    end;

    procedure InitSalesOrderNo(var SalesHeader: Record "Sales Header"; SalesOrderTempl: Record "Sales Order Templ.")
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if SalesOrderTempl."No. Series" = '' then
            exit;

        NoSeriesManagement.InitSeries(SalesOrderTempl."No. Series", '', 0D, Rec."No.", Rec."No. Series");
    end;

    procedure InitSalesOrderPostingNo(var SalesHeader: Record "Sales Header"; SalesOrderTempl: Record "Sales Order Templ.")
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin

        if SalesOrderTempl."Posting No. Series" = '' then
            exit;

        NoSeriesManagement.InitSeries(SalesOrderTempl."Posting No. Series", '', 0D, Rec."Posting No.", Rec."Posting No. Series");
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if NewMode then
            CreateSalesOrderFromTemplate()
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get();
        if GuiAllowed AND SalesReceivablesSetup."Sales Order Template" then begin
            if Rec."No." = '' then
                NewMode := true;
        end
    end;

    var
        NewMode: Boolean;
}
