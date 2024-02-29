table 50000 MyStudentTable
{
    Caption = 'MyStudentTable';
    DataClassification = ToBeClassified;
    LookupPageId = MyStudentPage;


    fields
    {

        field(500001; "Reg No."; Code[20])
        {
            Caption = 'Reg No.';

        }
        field(500002; Name; Text[50])
        {
            Caption = 'Name';

        }
        field(500003; course; Text[20])
        {
            Caption = 'course';

        }
        field(500004; balance; decimal)
        {
            Caption = 'balance';

        }
        field(500005; "start date"; Date)
        {
            Caption = 'start date';

        }
        field(500006; "end date"; date)
        {
            Caption = 'End Date';

        }
        field(500007; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = GLAccount,FixedAsset,Item;
        }
        field(500008; "No."; Integer)
        {




            TableRelation = IF (Type = CONST(Item)) Item
            ELSE

            IF (Type = CONST(FixedAsset)) "Fixed Asset"
            ELSE
            IF (Type = CONST(GLAccount)) "G/L Account"."No." where("Income/Balance" = filter("Income Statement"));


        }

    }
    keys
    {
        key(PK; "Reg No.")
        {
            Clustered = true;
        }

    }
    var
        GL: Record "g/l account";
        RQ: Page "Inventory Movement";
        PerfProf: Report "Aged Accounts Payable";
}