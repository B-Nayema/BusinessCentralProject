page 50017 "SCB API"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Test Results";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Private Key"; Rec."Private Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reg No. field.';
                    Editable = true;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {


            action(ViewAPI)
            {
                caption = 'View Data';
                Promoted = true;
                Visible = true;
                Enabled = true;
                RunPageMode = Edit;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = PostedPutAway;
                ApplicationArea = all;
                Scope = Page;
                Ellipsis = false;
                RunPageOnRec = false;
                InFooterBar = false;

                trigger OnAction()
                begin
                    //SCCod.HttpViewData();
                    //CleanerCod.POSTMethodAPI();
                    JWTTest.CreateJSON();
                    //JWTTest.ReadPrivateKey();
                end;
            }
        }
    }
    var
        SCCod: Codeunit "SC Codeunit";
        CleanerCod: Codeunit "APIs Codeunit";
        JWTTest: Codeunit CreateJWTTest;

}