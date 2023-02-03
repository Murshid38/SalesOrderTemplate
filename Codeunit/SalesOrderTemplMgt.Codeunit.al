// codeunit 50100 "Sales Order Templ. Mgt."
// {
//     procedure InsertCustomerFromTemplate(var Customer: Record Customer) Result: Boolean
//     var
//         IsHandled: Boolean;
//     begin
//         OnInsertCustomerFromTemplate(Customer, Result, IsHandled);
//     end;


//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Customer Templ. Mgt.", 'OnInsertCustomerFromTemplate', '', false, false)]
//     local procedure OnInsertCustomerFromTemplateHandler(var Customer: Record Customer; var Result: Boolean; var IsHandled: Boolean)
//     begin
//         if IsHandled then
//             exit;

//         Result := CreateCustomerFromTemplate(Customer, IsHandled);
//     end;

//     procedure CreateCustomerFromTemplate(var Customer: Record Customer; var IsHandled: Boolean) Result: Boolean
//     var
//         CustomerTempl: Record "Customer Templ.";
//     begin
//         IsHandled := false;
//         OnBeforeCreateCustomerFromTemplate(Customer, Result, IsHandled);
//         if IsHandled then
//             exit(Result);

//         IsHandled := true;

//         if not SelectCustomerTemplate(CustomerTempl) then
//             exit(false);

//         Customer.SetInsertFromTemplate(true);
//         Customer.Init();
//         InitCustomerNo(Customer, CustomerTempl);
//         Customer."Contact Type" := CustomerTempl."Contact Type";
//         Customer.Insert(true);
//         Customer.SetInsertFromTemplate(false);
//         ApplyCustomerTemplate(Customer, CustomerTempl);

//         OnAfterCreateCustomerFromTemplate(Customer, CustomerTempl);
//         exit(true);
//     end;

//     procedure SelectCustomerTemplate(var CustomerTempl: Record "Customer Templ.") Result: Boolean
//     var
//         SelectCustomerTemplList: Page "Select Customer Templ. List";
//         IsHandled: Boolean;
//     begin
//         IsHandled := false;
//         OnBeforeSelectCustomerTemplate(CustomerTempl, Result, IsHandled);
//         if IsHandled then
//             exit(Result);

//         if CustomerTempl.Count = 1 then begin
//             CustomerTempl.FindFirst();
//             exit(true);
//         end;

//         if (CustomerTempl.Count > 1) and GuiAllowed then begin
//             SelectCustomerTemplList.SetTableView(CustomerTempl);
//             SelectCustomerTemplList.LookupMode(true);
//             if SelectCustomerTemplList.RunModal() = Action::LookupOK then begin
//                 SelectCustomerTemplList.GetRecord(CustomerTempl);
//                 exit(true);
//             end;
//         end;

//         exit(false);
//     end;

//     local procedure CanBeUpdatedFromTemplate(var CustomerTempl: Record "Customer Templ."; var IsHandled: Boolean): Boolean
//     begin
//         IsHandled := true;

//         if not SelectCustomerTemplate(CustomerTempl) then
//             exit(false);

//         exit(true);
//     end;


//     procedure InitCustomerNo(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
//     var
//         NoSeriesManagement: Codeunit NoSeriesManagement;
//     begin
//         if CustomerTempl."No. Series" = '' then
//             exit;

//         NoSeriesManagement.InitSeries(CustomerTempl."No. Series", '', 0D, Customer."No.", Customer."No. Series");
//     end;


//     procedure ApplyCustomerTemplate(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
//     begin
//         ApplyCustomerTemplate(Customer, CustomerTempl, false);
//     end;

//     procedure ApplyCustomerTemplate(var Customer: Record Customer; CustomerTempl: Record "Customer Templ."; UpdateExistingValues: Boolean)
//     begin
//         ApplyTemplate(Customer, CustomerTempl, UpdateExistingValues);
//         InsertDimensions(Customer."No.", CustomerTempl.Code, Database::Customer, Database::"Customer Templ.");
//         Customer.Get(Customer."No.");

//         OnAfterApplyCustomerTemplate(Customer, CustomerTempl);
//     end;

//     local procedure ApplyTemplate(var Customer: Record Customer; CustomerTempl: Record "Customer Templ."; UpdateExistingValues: Boolean)
//     var
//         CustomerRecRef: RecordRef;
//         EmptyCustomerRecRef: RecordRef;
//         CustomerTemplRecRef: RecordRef;
//         EmptyCustomerTemplRecRef: RecordRef;
//         CustomerFldRef: FieldRef;
//         EmptyCustomerFldRef: FieldRef;
//         CustomerTemplFldRef: FieldRef;
//         EmptyCustomerTemplFldRef: FieldRef;
//         IsHandled: Boolean;
//         i: Integer;
//         FieldExclusionList: List of [Integer];
//     begin
//         IsHandled := false;
//         OnBeforeApplyTemplate(Customer, CustomerTempl, IsHandled);
//         if IsHandled then
//             exit;

//         CustomerRecRef.GetTable(Customer);
//         EmptyCustomerRecRef.Open(Database::Customer);
//         EmptyCustomerRecRef.Init();
//         CustomerTemplRecRef.GetTable(CustomerTempl);
//         EmptyCustomerTemplRecRef.Open(Database::"Customer Templ.");
//         EmptyCustomerTemplRecRef.Init();

//         FillFieldExclusionList(FieldExclusionList);

//         for i := 3 to CustomerTemplRecRef.FieldCount do begin
//             CustomerTemplFldRef := CustomerTemplRecRef.FieldIndex(i);
//             if TemplateFieldCanBeProcessed(CustomerTemplFldRef.Number, FieldExclusionList) then begin
//                 CustomerFldRef := CustomerRecRef.Field(CustomerTemplFldRef.Number);
//                 EmptyCustomerFldRef := EmptyCustomerRecRef.Field(CustomerTemplFldRef.Number);
//                 EmptyCustomerTemplFldRef := EmptyCustomerTemplRecRef.Field(CustomerTemplFldRef.Number);
//                 if (CustomerFldRef.Value = EmptyCustomerFldRef.Value) and (CustomerTemplFldRef.Value <> EmptyCustomerTemplFldRef.Value) or UpdateExistingValues then
//                     CustomerFldRef.Value := CustomerTemplFldRef.Value;
//             end;
//         end;
//         CustomerRecRef.SetTable(Customer);
//         if CustomerTempl."Invoice Disc. Code" <> '' then
//             Customer."Invoice Disc. Code" := CustomerTempl."Invoice Disc. Code";
//         Customer.Validate("Payment Method Code", CustomerTempl."Payment Method Code");
//         OnApplyTemplateOnBeforeCustomerModify(Customer, CustomerTempl);
//         Customer.Modify(true);
//     end;

//     procedure SelectCustomerTemplateFromContact(var CustomerTempl: Record "Customer Templ."; Contact: Record Contact): Boolean
//     begin
//         OnBeforeSelectCustomerTemplateFromContact(CustomerTempl, Contact);

//         CustomerTempl.SetRange("Contact Type", Contact.Type);
//         exit(SelectCustomerTemplate(CustomerTempl));
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterCreateCustomerFromTemplate(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeSelectCustomerTemplate(var CustomerTempl: Record "Customer Templ."; var Result: Boolean; var IsHandled: Boolean)
//     begin
//     end;

//     local procedure InsertDimensions(DestNo: Code[20]; SourceNo: Code[20]; DestTableId: Integer; SourceTableId: Integer)
//     var
//         SourceDefaultDimension: Record "Default Dimension";
//         DestDefaultDimension: Record "Default Dimension";
//     begin
//         SourceDefaultDimension.SetRange("Table ID", SourceTableId);
//         SourceDefaultDimension.SetRange("No.", SourceNo);
//         if SourceDefaultDimension.FindSet() then
//             repeat
//                 DestDefaultDimension.Init();
//                 DestDefaultDimension.Validate("Table ID", DestTableId);
//                 DestDefaultDimension.Validate("No.", DestNo);
//                 DestDefaultDimension.Validate("Dimension Code", SourceDefaultDimension."Dimension Code");
//                 DestDefaultDimension.Validate("Dimension Value Code", SourceDefaultDimension."Dimension Value Code");
//                 DestDefaultDimension.Validate("Value Posting", SourceDefaultDimension."Value Posting");
//                 if not DestDefaultDimension.Get(DestDefaultDimension."Table ID", DestDefaultDimension."No.", DestDefaultDimension."Dimension Code") then
//                     DestDefaultDimension.Insert(true);
//             until SourceDefaultDimension.Next() = 0;
//     end;

//     local procedure FillFieldExclusionList(var FieldExclusionList: List of [Integer])
//     var
//         CustomerTempl: Record "Customer Templ.";
//     begin
//         FieldExclusionList.Add(CustomerTempl.FieldNo("Invoice Disc. Code"));
//         FieldExclusionList.Add(CustomerTempl.FieldNo("No. Series"));
//         FieldExclusionList.Add(CustomerTempl.FieldNo("Payment Method Code"));

//         OnAfterFillFieldExclusionList(FieldExclusionList);
//     end;

//     local procedure TemplateFieldCanBeProcessed(FieldNumber: Integer; FieldExclusionList: List of [Integer]): Boolean
//     var
//         CustomerField: Record Field;
//         CustomerTemplateField: Record Field;
//     begin
//         if FieldExclusionList.Contains(FieldNumber) or (FieldNumber > 2000000000) then
//             exit(false);

//         if not (CustomerField.Get(Database::Customer, FieldNumber) and CustomerTemplateField.Get(Database::"Customer Templ.", FieldNumber)) then
//             exit(false);

//         if (CustomerField.Class <> CustomerField.Class::Normal) or (CustomerTemplateField.Class <> CustomerTemplateField.Class::Normal) or
//             (CustomerField.Type <> CustomerTemplateField.Type) or (CustomerField.FieldName <> CustomerTemplateField.FieldName) or
//             (CustomerField.Len <> CustomerTemplateField.Len) or
//             (CustomerField.ObsoleteState = CustomerField.ObsoleteState::Removed) or
//             (CustomerTemplateField.ObsoleteState = CustomerTemplateField.ObsoleteState::Removed)
//         then
//             exit(false);

//         exit(true);
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnInsertCustomerFromTemplate(var Customer: Record Customer; var Result: Boolean; var IsHandled: Boolean)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnApplyTemplateOnBeforeCustomerModify(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeSelectCustomerTemplateFromContact(var CustomerTempl: Record "Customer Templ."; Contact: Record Contact)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterFillFieldExclusionList(var FieldExclusionList: List of [Integer])
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeApplyTemplate(var Customer: Record Customer; CustomerTempl: Record "Customer Templ."; var IsHandled: Boolean)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeCreateCustomerFromTemplate(var Customer: Record Customer; var Result: Boolean; var IsHandled: Boolean)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterApplyCustomerTemplate(var Customer: Record Customer; CustomerTempl: Record "Customer Templ.")
//     begin
//     end;
// }
