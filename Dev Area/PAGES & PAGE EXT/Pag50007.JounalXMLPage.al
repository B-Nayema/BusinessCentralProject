/*page 50007 JounalXMLPage
{
    Caption = 'JounalXMLPage';
    PageType = Card;
    SourceTable = SampleJournalXML;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount         field.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount (LCY)   field.';
                }
                /*field("document type"; Rec."document type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the document type field.';
                }
                field(description; Rec.description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the description field.';
                }
                field(currency; Rec.currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the currency field.';
                }
                field("account name"; Rec."account name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the account name field.';
                }
                field("Bal. Account N"; Rec."Bal. Account N")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Account N field.';
                }
                field("Bal. Account T"; Rec."Bal. Account T")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Account T field.';
                }
                field("Bal. Gen. Bus."; Rec."Bal. Gen. Bus.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Gen. Bus. field.';
                }
                field("Bal. Gen. Post"; Rec."Bal. Gen. Post")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Gen. Post field.';
                }
                field("Bal. Gen. Prod"; Rec."Bal. Gen. Prod")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Gen. Prod field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment        field.';
                }
                field(Correction; Rec.Correction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Correction     field.';
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deferral Code  field.';
                }
                field("Dept Code"; Rec."Dept Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dept Code      field.';
                }
                field("EU 3-Party"; Rec."EU 3-Party")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EU 3-Party field.';
                }
                field("Fleet Code"; Rec."Fleet Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fleet Code     field.';
                }
                field("Gen. Bus. Post"; Rec."Gen. Bus. Post")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Bus. Post field.';
                }
                field("Gen. Posting T"; Rec."Gen. Posting T")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Posting T field.';
                }
                field("Gen. Prod. Pos"; Rec."Gen. Prod. Pos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen. Prod. Pos field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ImportXML)
            {
                caption = 'Import Items';
                promoted = true;
                promotedCategory = Process;
                Image = Import;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    xmlport.Run(50002, false, true);
                end;
            }
        }
    }
    procedure ImportXMLData()
    var
        FromFile: Text;
        Inbtr: InStream;
    begin
        UploadIntoStream('Upload XML File', '', '', FromFile, Inbtr)
    end;
}



   procedure AddRequest(HttpMethod: Text[6]) ResponseText: Text
    var
        Client: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        RequestHeaders: HttpHeaders;
        RequestURI: Text;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
    begin
        RequestURI := 'https://httpcats.com/418.json';

        // This shows how you can set or change HTTP content headers in your request
          Content.GetHeaders(ContentHeaders);
         if ContentHeaders.Contains('Content-Type') then Requestheaders.Remove('Content-Type');
         ContentHeaders.Add('Content-Type', 'multipart/form-data;boundary=boundary'); 

        // This shows how you can set HTTP request headers in your request
        HttpRequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Accept', 'application/json');
        RequestHeaders.Add('Accept-Encoding', 'utf-8');
        RequestHeaders.Add('Connection', 'Keep-alive');

        HttpRequestMessage.SetRequestUri(RequestURI);
        HttpRequestMessage.Method(HttpMethod);

        // from here on, the method must deal with calling out to the external service. 
        // see example code snippets below
    end;

    procedure SCBGetInfo() ResponseText: Text
    var
        Client: HttpClient;
        IsSuccessful: Boolean;
        HttpResponseMessage: HttpResponseMessage;
        ServiceStatusErr: Label 'Web service call failed.';
        ErrorInfoObject: ErrorInfo;
        HttpStatusCode: Integer;
    begin

        //Error Handling
        IsSuccessful := Client.Get(URL, HttpResponseMessage);

        if not IsSuccessful then begin
            // handle the error
        end;

        if not HttpResponseMessage.IsSuccessStatusCode() then begin
            HttpStatusCode := HttpResponseMessage.HttpStatusCode();
            ErrorInfoObject.DetailedMessage := 'Sorry, we could not retrieve the cat info right now. ';
            ErrorInfoObject.Message := Format(ServiceStatusErr, HttpStatusCode, HttpResponseMessage.ReasonPhrase());
            Error(ErrorInfoObject);
        end;

        HttpResponseMessage.Content().ReadAs(ResponseText);

        //post data
        HttpRequestMessage.SetRequestUri('apitest.standardchartered.com');
        HttpRequestMessage.Method('GET');
        HttpRequestMessage.GetHeaders(HttpHeaders);
        If HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            HttpResponseMessage.Content.ReadAs(Response);
            if HttpResponseMessage.IsSuccessStatusCode then begin
                JsonObject.ReadFrom(Response);
                GenJnlLine.ReadFromText(Response);
                Page.Run(Page::"Payment Journal", GenJnlLine);


            end else
                Message('Request Failed!: %1', Response);

        end;


    end;

*/
