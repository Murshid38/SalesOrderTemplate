codeunit 50101 "Generate Sales Order Template"
{

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnNewRecordEvent', '', true, true)]
    // local procedure CreateNewSalesOrder()
    // var
    //     SelectSalesOrderTempl: Page "Select Sales Order Templ. List";
    //     SalesOrderTempl: Record "Sales Order Templ.";
    // begin

    //     if SalesOrderTempl.Count = 1 then
    //         SalesOrderTempl.FindFirst()
    //     else
    //         if (SalesOrderTempl.Count > 1) and GuiAllowed then begin
    //             SelectSalesOrderTempl.SetTableView(SalesOrderTempl);
    //             SelectSalesOrderTempl.LookupMode(true);
    //             if SelectSalesOrderTempl.RunModal() = Action::LookupOK then begin
    //                 SelectSalesOrderTempl.GetRecord(SalesOrderTempl);
    //             end;
    //         end;
    // end;

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnOpenPageEvent', '', true, true)]
    // local procedure MyProcedure()
    // begin
    //     Message('Hello World');
    // end;
}
