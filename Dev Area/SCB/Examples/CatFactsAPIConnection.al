page 50015 CatFactsAPI

{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Cat Facts API';

    actions
    {
        area(Processing)
        {

            action(InitAPI)
            {
                caption = 'Post on API';
                Promoted = true;
                Visible = true;
                Enabled = true;
                RunPageMode = Edit;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Components;
                ApplicationArea = all;
                Scope = Page;
                Ellipsis = false;
                RunPageOnRec = false;
                InFooterBar = false;

                trigger OnAction()
                var
                    URL: Label 'https://catfact.ninja/fact';
                    Username: Text[100];
                    Password: Text[100];
                begin
                    PostVarAPI();
                end;
            }
            action(GetAPI)
            {
                caption = 'Random Fact';
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
                    BasicAPI();
                end;
            }
        }
    }





    Procedure BasicAPI()
    var

        Response: Text;
    begin
        if HttpClient.Get(URL, HttpResponseMessage) THEN begin
            HttpResponseMessage.Content.ReadAs(Response);
            Message(Response);
        end;
    end;


    procedure HttpRequestCatFacts(URL: Text[2048]; Username: Text[100]; Password: Text[100])
    begin
        // Create a HTTP Request Message
        HttpRequestMessage.SetRequestUri(url);
        HttpRequestMessage.Method('GET');

        //Add Authorization
        // HttpRequestMessage.GetHeaders(HttpHeaders);
        // HttpHeaders.Add('Authorization', 'Basic' + Base64Convert.ToBase64(Username + ':' + Password));

        //Send Request and Get Response
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            //Read Response
            HttpResponseMessage.Content.ReadAs(Response);

            //Handle the Response
            if HttpResponseMessage.IsSuccessStatusCode then begin
                Message('Request Successful! Response: %1', Response);
            end else
                Message('Request failed!: %1', Response);
        end;

    end;

    procedure PostVarAPI()
    begin
        HttpRequestMessage.SetRequestUri(URL);
        HttpRequestMessage.Method('POST');
        HttpRequestMessage.GetHeaders(HttpHeaders);
        /*         If HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
                    HttpResponseMessage.Content.ReadAs(Response);
                    if HttpResponseMessage.IsSuccessStatusCode then begin
                        JsonObject.ReadFrom(Response);
                        JsonBuffer.ReadFromText(Response);
                        Page.Run(Page::"JSON Buffer BCG", JsonBuffer);


                    end else
                        Message('Request Failed!: %1', Response);

                end; */
        httpContent.WriteFrom(JsonOb.CreateSimpleJSON());
        httpclient.Post(url, httpContent, HttpResponseMessage);

    end;


    var
        HttpClient: HttpClient;
        HttpHeaders: HttpHeaders;
        HttpContent: HttpContent;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Base64Convert: Codeunit "Base64 Convert";
        Response: Text;
        URL: Label 'https://catfact.ninja/fact';
        JsonObject: JsonObject;
        JsonBuffer: Record "JSON Buffer" temporary;
        JsonOb: Codeunit "JSON Objects";


}