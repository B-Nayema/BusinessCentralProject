pageextension 50001 CompInfo extends "Company Information"
{
    layout
    {
        addafter(Address)
        {
            field("Public Key File"; Rec."Public Key File")
            {
                ApplicationArea = all;

            }
            field("Private Key File"; Rec."Private Key File")
            {
                ApplicationArea = all;
            }
            field(PassPhrase; Rec.PassPhrase)
            {
                ApplicationArea = all;
            }
            field(Image; Rec.Image)
            {

                ApplicationArea = Basic, suite;

            }
        }
    }
}
