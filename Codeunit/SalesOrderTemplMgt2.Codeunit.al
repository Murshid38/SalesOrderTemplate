// codeunit 50100 "Sales Order Templ. Mgt. 2"
// {
//     procedure InsertSalesOrderFromTemplate(var SalesHeader: Record "Sales Header") Result: Boolean
//     var
//         IsHandled: Boolean;
//     begin
//         // OnInsertSalesOrderFromTemplate(SalesHeader, Result, IsHandled);
//         if IsHandled then
//             exit;

//         Result := CreateSalesOrderFromTemplate(SalesHeader, IsHandled);
//     end;


//     // [EventSubscriber(ObjectType::Codeunit, Codeunit::"SalesHeader Templ. Mgt.", 'OnInsertSalesOrderFromTemplate', '', false, false)]
//     // local procedure OnInsertSalesHeaderFromTemplateHandler(var SalesHeader: Record SalesHeader; var Result: Boolean; var IsHandled: Boolean)
//     // begin
//     //     if IsHandled then
//     //         exit;

//     //     Result := CreateSalesHeaderFromTemplate(SalesHeader, IsHandled);
//     // end;

//     procedure CreateSalesOrderFromTemplate(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean) Result: Boolean
//     var
//         SalesOrderTempl: Record "Sales Order Templ.";
//     begin
//         IsHandled := false;
//         if IsHandled then
//             exit(Result);

//         IsHandled := true;

//         if not SelectSalesOrderTemplate(SalesOrderTempl) then
//             exit(false);

//         // SalesHeader.SetInsertFromTemplate(true);
//         SalesHeader.Init();
//         InitSalesOrderNo(SalesHeader, SalesOrderTempl);
//         SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
//         SalesHeader.Insert(true);
//         // SalesHeader.SetInsertFromTemplate(false);
//         ApplySalesOrderTemplate(SalesHeader, SalesOrderTempl);

//         exit(true);
//     end;

//     procedure SelectSalesOrderTemplate(var SalesOrderTempl: Record "Sales Order Templ.") Result: Boolean
//     var
//         SelectSalesOrderTemplList: Page "Select Sales Order Templ. List";
//         IsHandled: Boolean;
//     begin
//         IsHandled := false;
//         if IsHandled then
//             exit(Result);

//         if SalesOrderTempl.Count = 1 then begin
//             SalesOrderTempl.FindFirst();
//             exit(true);
//         end;

//         if (SalesOrderTempl.Count > 1) and GuiAllowed then begin
//             SelectSalesOrderTemplList.SetTableView(SalesOrderTempl);
//             SelectSalesOrderTemplList.LookupMode(true);
//             if SelectSalesOrderTemplList.RunModal() = Action::LookupOK then begin
//                 SelectSalesOrderTemplList.GetRecord(SalesOrderTempl);
//                 exit(true);
//             end;
//         end;

//         exit(false);
//     end;

//     //     local procedure CanBeUpdatedFromTemplate(var SalesHeaderTempl: Record "SalesHeader Templ."; var IsHandled: Boolean): Boolean
//     //     begin
//     //         IsHandled := true;

//     //         if not SelectSalesHeaderTemplate(SalesHeaderTempl) then
//     //             exit(false);

//     //         exit(true);
//     //     end;


//     procedure InitSalesOrderNo(var SalesHeader: Record "Sales Header"; SalesOrderTempl: Record "Sales Order Templ.")
//     var
//         NoSeriesManagement: Codeunit NoSeriesManagement;
//     begin
//         if SalesOrderTempl."No. Series" = '' then
//             exit;

//         NoSeriesManagement.InitSeries(SalesOrderTempl."No. Series", '', 0D, SalesHeader."No.", SalesHeader."No. Series");
//     end;


//     procedure ApplySalesOrderTemplate(var SalesHeader: Record "Sales Header"; SalesOrderTempl: Record "Sales Order Templ.")
//     begin
//         ApplySalesOrderTemplate(SalesHeader, SalesOrderTempl, false);
//     end;

//     procedure ApplySalesOrderTemplate(var SalesHeader: Record "Sales Header"; SalesOrderTempl: Record "Sales Order Templ."; UpdateExistingValues: Boolean)
//     begin
//         ApplyTemplate(SalesHeader, SalesOrderTempl, UpdateExistingValues);
//         SalesHeader.Get(SalesHeader."Document Type"::Order, SalesHeader."No.");
//     end;

//     local procedure ApplyTemplate(var SalesHeader: Record "Sales Header"; SalesOrderTempl: Record "Sales Order Templ."; UpdateExistingValues: Boolean)
//     var
//     // SalesHeaderRecRef: RecordRef;
//     // EmptySalesHeaderRecRef: RecordRef;
//     // SalesOrderTemplRecRef: RecordRef;
//     // EmptySalesOrderTemplRecRef: RecordRef;
//     // SalesHeaderFldRecRef: FieldRef;
//     // EmptySalesHeaderFldRecRef: FieldRef;
//     // SalesOrderTemplFldRecRef: FieldRef;
//     // EmptySalesOrderTemplFldRecRef: FieldRef;
//     // IsHandled: Boolean;
//     // i: Integer;
//     // FieldExclusionList: List of [Integer];
//     begin
//         // IsHandled := false;
//         // if IsHandled then
//         //     exit;

//         // SalesHeaderRecRef.GetTable(SalesHeader);
//         // EmptySalesHeaderRecRef.Open(Database::"Sales Header");
//         // EmptySalesHeaderRecRef.Init();
//         // SalesOrderTemplRecRef.GetTable(SalesOrderTempl);
//         // EmptySalesOrderTemplRecRef.Open(Database::"Sales Order Templ.");
//         // EmptySalesOrderTemplRecRef.Init();

//         // FillFieldExclusionList(FieldExclusionList);

//         // Message('%1', SalesOrderTemplRecRef.FieldCount);

//         // for i := 1 to SalesOrderTemplRecRef.FieldCount do begin
//         //     SalesOrderTemplFldRecRef := SalesOrderTemplRecRef.FieldIndex(i);
//         //     // if TemplateFieldCanBeProcessed(SalesOrderTemplFldRecRef.Number, FieldExclusionList) then begin
//         //     SalesHeaderFldRecRef := SalesHeaderRecRef.Field(SalesOrderTemplFldRecRef.Number);
//         //     EmptySalesHeaderFldRecRef := EmptySalesHeaderRecRef.Field(SalesOrderTemplFldRecRef.Number);
//         //     EmptySalesOrderTemplFldRecRef := EmptySalesOrderTemplRecRef.Field(SalesOrderTemplFldRecRef.Number);
//         //     // if (SalesHeaderFldRecRef.Value = EmptySalesHeaderFldRecRef.Value) and (SalesOrderTemplFldRecRef.Value <> EmptySalesOrderTemplFldRecRef.Value) or UpdateExistingValues then
//         //     //     SalesHeaderFldRecRef.Value := SalesOrderTemplFldRecRef.Value;
//         //     // end;
//         // end;
//         // SalesHeaderRecRef.SetTable(SalesHeader);
//         // // if SalesHeaderTempl."Invoice Disc. Code" <> '' then
//         //     SalesHeader."Invoice Disc. Code" := SalesHeaderTempl."Invoice Disc. Code";
//         // SalesHeader.Validate("Payment Method Code", SalesHeaderTempl."Payment Method Code");
//         // SalesHeader.Modify(true);

//         SalesHeader."Your Reference" := SalesOrderTempl."Your Reference";
//         SalesHeader.Modify();
//     end;

//     //     procedure SelectSalesHeaderTemplateFromContact(var SalesHeaderTempl: Record "SalesHeader Templ."; Contact: Record Contact): Boolean
//     //     begin
//     //         OnBeforeSelectSalesHeaderTemplateFromContact(SalesHeaderTempl, Contact);

//     //         SalesHeaderTempl.SetRange("Contact Type", Contact.Type);
//     //         exit(SelectSalesHeaderTemplate(SalesHeaderTempl));
//     //     end;

//     //     [IntegrationEvent(false, false)]
//     //     local procedure OnAfterCreateSalesHeaderFromTemplate(var SalesHeader: Record SalesHeader; SalesHeaderTempl: Record "SalesHeader Templ.")
//     //     begin
//     //     end;

//     //     [IntegrationEvent(false, false)]
//     //     local procedure OnBeforeSelectSalesHeaderTemplate(var SalesHeaderTempl: Record "SalesHeader Templ."; var Result: Boolean; var IsHandled: Boolean)
//     //     begin
//     //     end;

//     //     local procedure InsertDimensions(DestNo: Code[20]; SourceNo: Code[20]; DestTableId: Integer; SourceTableId: Integer)
//     //     var
//     //         SourceDefaultDimension: Record "Default Dimension";
//     //         DestDefaultDimension: Record "Default Dimension";
//     //     begin
//     //         SourceDefaultDimension.SetRange("Table ID", SourceTableId);
//     //         SourceDefaultDimension.SetRange("No.", SourceNo);
//     //         if SourceDefaultDimension.FindSet() then
//     //             repeat
//     //                 DestDefaultDimension.Init();
//     //                 DestDefaultDimension.Validate("Table ID", DestTableId);
//     //                 DestDefaultDimension.Validate("No.", DestNo);
//     //                 DestDefaultDimension.Validate("Dimension Code", SourceDefaultDimension."Dimension Code");
//     //                 DestDefaultDimension.Validate("Dimension Value Code", SourceDefaultDimension."Dimension Value Code");
//     //                 DestDefaultDimension.Validate("Value Posting", SourceDefaultDimension."Value Posting");
//     //                 if not DestDefaultDimension.Get(DestDefaultDimension."Table ID", DestDefaultDimension."No.", DestDefaultDimension."Dimension Code") then
//     //                     DestDefaultDimension.Insert(true);
//     //             until SourceDefaultDimension.Next() = 0;
//     //     end;

//     // local procedure FillFieldExclusionList(var FieldExclusionList: List of [Integer])
//     // var
//     //     SalesOrderTempl: Record "Sales Order Templ.";
//     // begin
//     //     // FieldExclusionList.Add(SalesOrderTempl.FieldNo("Invoice Disc. Code"));
//     //     FieldExclusionList.Add(SalesOrderTempl.FieldNo("No. Series"));
//     //     // FieldExclusionList.Add(SalesOrderTempl.FieldNo("Payment Method Code"));
//     // end;

//     // local procedure TemplateFieldCanBeProcessed(FieldNumber: Integer; FieldExclusionList: List of [Integer]): Boolean
//     // var
//     //     SalesHeaderField: Record Field;
//     //     SalesHeaderTemplateField: Record Field;
//     // begin
//     //     if FieldExclusionList.Contains(FieldNumber) or (FieldNumber > 2000000000) then
//     //         exit(false);

//     //     if not (SalesHeaderField.Get(Database::"Sales Header", FieldNumber) and SalesHeaderTemplateField.Get(Database::"Sales Order Templ.", FieldNumber)) then
//     //         exit(false);

//     //     if (SalesHeaderField.Class <> SalesHeaderField.Class::Normal) or (SalesHeaderTemplateField.Class <> SalesHeaderTemplateField.Class::Normal) or
//     //         (SalesHeaderField.Type <> SalesHeaderTemplateField.Type) or (SalesHeaderField.FieldName <> SalesHeaderTemplateField.FieldName) or
//     //         (SalesHeaderField.Len <> SalesHeaderTemplateField.Len) or
//     //         (SalesHeaderField.ObsoleteState = SalesHeaderField.ObsoleteState::Removed) or
//     //         (SalesHeaderTemplateField.ObsoleteState = SalesHeaderTemplateField.ObsoleteState::Removed)
//     //     then
//     //         exit(false);

//     //     exit(true);
//     // end;

//     // procedure InsertSalesHeaderFromTemplate(var SalesHeader: Record SalesHeader) Result: Boolean
//     // var
//     //     IsHandled: Boolean;
//     // begin
//     //     OnInsertSalesHeaderFromTemplate(SalesHeader, Result, IsHandled);
//     // end;

//     // [IntegrationEvent(false, false)]
//     // local procedure OnInsertSalesOrderFromTemplate(var SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean)
//     // begin
//     // end;

//     //     [IntegrationEvent(false, false)]
//     //     local procedure OnApplyTemplateOnBeforeSalesHeaderModify(var SalesHeader: Record SalesHeader; SalesHeaderTempl: Record "SalesHeader Templ.")
//     //     begin
//     //     end;

//     //     [IntegrationEvent(false, false)]
//     //     local procedure OnBeforeSelectSalesHeaderTemplateFromContact(var SalesHeaderTempl: Record "SalesHeader Templ."; Contact: Record Contact)
//     //     begin
//     //     end;

//     //     [IntegrationEvent(false, false)]
//     //     local procedure OnAfterFillFieldExclusionList(var FieldExclusionList: List of [Integer])
//     //     begin
//     //     end;

//     //     [IntegrationEvent(false, false)]
//     //     local procedure OnBeforeApplyTemplate(var SalesHeader: Record SalesHeader; SalesHeaderTempl: Record "SalesHeader Templ."; var IsHandled: Boolean)
//     //     begin
//     //     end;

//     //     [IntegrationEvent(false, false)]
//     //     local procedure OnBeforeCreateSalesHeaderFromTemplate(var SalesHeader: Record SalesHeader; var Result: Boolean; var IsHandled: Boolean)
//     //     begin
//     //     end;

//     //     [IntegrationEvent(false, false)]
//     //     local procedure OnAfterApplySalesOrderTemplate(var SalesHeader: Record SalesHeader; SalesHeaderTempl: Record "SalesHeader Templ.")
//     //     begin
//     //     end;
// }
