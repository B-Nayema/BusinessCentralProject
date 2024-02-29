reportextension 50002 "50002OrderRptExt.al" extends "Order"
{
    dataset
    {


        add(CopyLoop)
        {


            column(Picture; CompInfo.Picture)
            {

            }


        }

        add("Purchase Header")
        {
            column(PurchaseOrderCpt; PurchaseOrderCpt)
            {

            }
            column(PurchOrder; PurchOrder)
            {

            }

        }

    }
    rendering
    {

        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './layout/Order.rdl';
        }
    }
    trigger OnPreReport()
    begin


        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;


    var
        CompInfo: Record "Company Information";
        Test: Report "Standard Sales - Invoice";
        PurchaseOrderCpt: Label 'Purchase Order';
        PurchOrder: Label 'Purchase Order No.';




}
