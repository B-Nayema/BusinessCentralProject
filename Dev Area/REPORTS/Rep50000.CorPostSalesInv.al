report 50000 CorrPostSalesInv
{
    ApplicationArea = All;
    Caption = 'Correct Posted Sales Invoice';
    ProcessingOnly = true;
    UseRequestPage = true;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Posting Date";

            trigger OnAfterGetRecord()
            var
                CorrectiveCod: Codeunit "Correct Posted Sales Invoice";
                SalesHeader: Record "Sales Header";

            begin

                CorrectiveCod.CancelPostedInvoiceCreateNewInvoice(SalesInvoiceHeader, SalesHeader);

            end;



        }
    }




}