table 50016 "Test Results"
{
    Caption = 'Test Results';


    fields
    {
        field(1; "Private Key"; Text[2048])
        {
            Caption = 'Private Key';
            DataClassification = ToBeClassified;
            Editable = true;

        }
        field(2; "Original Key"; Text[2048])
        {
            Caption = 'Original Key';
            DataClassification = ToBeClassified;
            Editable = true;

        }
    }
    keys
    {
        key(PK; "Private Key")
        {
            Clustered = true;
        }
    }
    var
        JWTTest: Codeunit CreateJWTTest;

}
