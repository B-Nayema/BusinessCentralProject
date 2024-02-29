codeunit 50007 "SC Codeunit"
{
    procedure HttpViewData()
    var
        URL: Text[2048];
        Username: Text[100];
        Password: Text[100];
    begin
        // Create a HTTP Request Message
        URL := 'https://axess.sc.com/api/sbfunc/clientData/tryitout/payments/v2/initiate';
        //URL := 'https://jsonplaceholder.typicode.com/todos';
        HttpRequestMessage.SetRequestUri(URL);
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
                Message('Request failed! %1', Response);
        end;
    end;

    procedure EditHttp(json: Text) ResponseText: Text
    var
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        IsSuccessful: Boolean;
        Response: HttpResponseMessage;
        HttpStatusCode: Integer;

    begin
        Content.GetHeaders(ContentHeaders);

        if ContentHeaders.Contains('Content-Type') then Contentheaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');

        if ContentHeaders.Contains('Content-Encoding') then Contentheaders.Remove('Content-Encoding');
        ContentHeaders.Add('Content-Encoding', 'UTF8');

        // assume that the json parameter contains the following data
        //
        // {
        //    userId = 77,
        //    id = 1,
        //    title = "write code sample",
        //    completed = false
        // }
        Content.WriteFrom(json);

        IsSuccessful := Client.Post('https://jsonplaceholder.typicode.com/todos', Content, Response);

        if not IsSuccessful then begin
            // handle the error
        end;

        if not Response.IsSuccessStatusCode() then begin
            HttpStatusCode := response.HttpStatusCode();
            // handle the error (depending on the HTTP status code)
        end;

        Response.Content().ReadAs(ResponseText);

        // Expected output:
        //   POST https://jsonplaceholder.typicode.com/todos HTTP/1.1
        //   {
        //     "userId": 77,
        //     "id": 201,
        //     "title": "write code sample",
        //     "completed": false
        //   }
    end;

    procedure EncryptCryptographyBC(PWD: Text): text
    var
        CryptographyManagement: codeunit "Cryptography Management";
        HashAlgorithmType: Option MD5,SHA1,SHA256,SHA384,SHA512;
    begin
        //Returns MD5 Hash of input string. Based on the requirement we can have options to use different hashing algorithm
        CryptographyManagement.GenerateHash('sss', 'sss', HashAlgorithmType::SHA1);
        exit(CryptographyManagement.GenerateHash(PWD, HashAlgorithmType::MD5));


    end;



    var
        HttpClient: HttpClient;
        HttpHeaders: HttpHeaders;
        HttpContent: HttpContent;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Base64Convert: Codeunit "Base64 Convert";
        Response: Text;
        URL: Label 'apitest.standardchartered.com';
        JsonObject: JsonObject;
        GenJnlLine: Record "Gen. Journal Line" temporary;


    var
        myInt: codeunit "Cryptography Management";
}