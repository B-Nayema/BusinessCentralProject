page 50018 "JSON TEST"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    actions
    {
        area(Creation)
        {
            action(TestJSON)
            {
                caption = 'Test JSON';
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
                var
                    JSONObjects: codeunit "JSON Objects";
                    TestClient: Codeunit "Understanding HTTP Client";
                    i: integer;
                begin
                    //JSONObjects.CreateSimpleJSON();
                    //JSONObjects.ComplicatedJson();
                    TestClient.clientPost();
                end;
            }
        }
    }
}