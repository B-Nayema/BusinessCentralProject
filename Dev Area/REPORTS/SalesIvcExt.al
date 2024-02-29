reportextension 50003 SalesIvcExt extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Header)
        {
            column(NewSalesInvoiceTitle; SalesInvoiceLbl1)
            {

            }
            column(DocumentNo_Lbl1; InvNoLbl1)
            {
            }
            column(PaymentTermsDescription_Lbl1; PaymentTermsDescLbl1)
            {
            }
            column(PaymentMethodDescription_Lbl1; PaymentMethodDescLbl1)
            {
            }
            column(EMail_Header_Lbl1; EMailLbl1)
            {
            }
            column(HomePage_Header_Lbl1; HomePageLbl1)
            {
            }
            column(CompanyPhoneNo_Lbl1; CompanyInfoPhoneNoLbl1)
            {
            }
            column(CompanyBankName_Lbl1; CompanyInfoBankNameLbl1)
            {
            }

        }
        addafter(PaymentReportingArgument)
        {

            dataitem(RightHeader1; "Name/Value Buffer")
            {
                DataItemTableView = SORTING(ID);
                UseTemporary = true;
                column(RightHeaderName1; Name)
                {
                }
                column(RightHeaderValue1; Value)
                {
                }
            }
            dataitem(LeftHeader1; "Name/Value Buffer")
            {
                DataItemTableView = SORTING(ID);
                UseTemporary = true;
                column(LeftHeaderName1; Name)
                {
                }
                column(LeftHeaderValue1; Value)
                {
                }

            }
        }


    }
    rendering
    {

        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './layout/SalesInvoice.rdl';
        }
    }
    trigger OnPreReport()
    begin
        if not CompBankAccount.Get(Header."Company Bank Account Code") then
            CompBankAccount.CopyBankFieldsFromCompanyInfo(CompInfo);

        FillLeftHeader1;
        FillRightHeader1;
    end;

    local procedure FillLeftHeader1()
    begin
        LeftHeader.DeleteAll();

        FillNameValueTable(LeftHeader, Header.FieldCaption("External Document No."), Header."External Document No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Bill-to Customer No."), Header."Bill-to Customer No.");
        FillNameValueTable(LeftHeader, Header.GetCustomerVATRegistrationNumberLbl, Header.GetCustomerVATRegistrationNumber);
        FillNameValueTable(LeftHeader, Header.GetCustomerGlobalLocationNumberLbl, Header.GetCustomerGlobalLocationNumber);
        FillNameValueTable(LeftHeader, InvNoLbl1, Header."No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Order No."), Header."Order No.");
        FillNameValueTable(LeftHeader, Header.FieldCaption("Document Date"), Format(Header."Document Date", 0, 4));
        FillNameValueTable(LeftHeader, Header.FieldCaption("Due Date"), Format(Header."Due Date", 0, 4));
        FillNameValueTable(LeftHeader, PaymentTermsDescLbl1, PaymentTerms1.Description);
        FillNameValueTable(LeftHeader, PaymentMethodDescLbl1, PaymentMethod1.Description);

        OnAfterFillLeftHeader(LeftHeader, Header);
    end;

    local procedure FillRightHeader1()
    begin
        RightHeader.DeleteAll();

        FillNameValueTable(RightHeader, EMailLbl1, CompInfo."E-Mail");
        FillNameValueTable(RightHeader, HomePageLbl1, CompInfo."Home Page");
        FillNameValueTable(RightHeader, CompanyInfoPhoneNoLbl1, CompInfo."Phone No.");
        FillNameValueTable(RightHeader, CompInfo.GetRegistrationNumberLbl, CompInfo.GetRegistrationNumber);
        FillNameValueTable(RightHeader, CompanyInfoBankNameLbl1, CompBankAccount.Name);
        FillNameValueTable(RightHeader, CompBankAccount.FieldCaption(IBAN), CompBankAccount.IBAN);
        FillNameValueTable(RightHeader, CompBankAccount.FieldCaption("SWIFT Code"), CompBankAccount."SWIFT Code");
        FillNameValueTable(RightHeader, Header.GetPaymentReferenceLbl, Header.GetPaymentReference);

        OnAfterFillRightHeader(RightHeader, Header);
    end;

    local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    var
        KeyIndex: Integer;
    begin
        if Value <> '' then begin
            Clear(NameValueBuffer);
            if NameValueBuffer.FindLast() then
                KeyIndex := NameValueBuffer.ID + 1;

            NameValueBuffer.Init();
            NameValueBuffer.ID := KeyIndex;
            NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
            NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
            NameValueBuffer.Insert();
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillRightHeader(var RightHeader: Record "Name/Value Buffer"; SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillLeftHeader(var LeftHeader: Record "Name/Value Buffer"; SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;

    var
        PaymentMethodDescLbl1: Label 'Payment Method';
        PaymentTermsDescLbl1: Label 'Payment Terms';
        InvNoLbl1: Label 'Invoice No.';
        PaymentTerms1: Record "Payment Terms";
        PaymentMethod1: Record "Payment Method";
        CompInfo: Record "Company Information";
        CompBankAccount: Record "Bank Account";
        CompanyInfoBankNameLbl1: Label 'Bank';
        CompanyInfoPhoneNoLbl1: Label 'Phone No.';
        HomePageLbl1: Label 'Home Page';
        EMailLbl1: Label 'Email';
        SalesInvoiceLbl1: Label 'Sales Invoice';

}