tableextension 50011 LookUpTable extends "Purchase Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                purchaseHeader: record "Purchase Header";
                GenJnl: Record "G/L Account";
            begin
                purchaseHeader.Get("No.");
                if Type = Type::"G/L Account" then
                    GenJnl.SetRange("No.", '4000', '9000')
            end;
        }
    }
}
