tableextension 50012 CompInfo extends "Company Information"
{
    fields
    {
        field(50000; "Public Key File"; Text[200])
        {
            Caption = 'Public Key File';
            DataClassification = ToBeClassified;
        }
        field(50001; "Private Key File"; Text[2048])
        {
            Caption = 'Private Key File';
            DataClassification = ToBeClassified;
        }
        field(50002; "Image"; Media)
        {
            Caption = 'Company Logo';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Person;
        }
        field(50003; Passphrase; Text[50])
        {
            Caption = 'Image';
            DataClassification = ToBeClassified;


            trigger OnValidate()
            begin

            end;
        }
        modify(Picture)
        {
            trigger OnAfterValidate()
            begin
                if Picture.HasValue then begin

                end;
            end;
        }
    }
    var
        CustTentMedia: Record "Tenant Media";
        ItemTenantMedia: Record "Tenant Media";
}
