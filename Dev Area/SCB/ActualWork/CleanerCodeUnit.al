codeunit 50008 "APIs Codeunit"
{
    procedure POSTMethodAPI()
    BEGIN
        //URL := 'http://api.standardchartered.com//openapi/payments/v2/initiate';
        //URL := 'https://axess.sc.com/api/sbfunc/clientData/tryitout/payments/v2/initiate';
        URL := 'https://jsonplaceholder.typicode.com/todos';
        Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');
        RequestMessage.SetRequestUri(URL);
        RequestMessage.Method := 'POST';
        if ResponseMessage.IsBlockedByEnvironment = true
            then begin
            Message('Blocked by Environment');
            exit;
        end
        else begin

            //content := JsonOb.GivenJson();
            Content := EncryptedJSON.TestRSA();
            Client.Post(url, content, ResponseMessage);
        end;

        if Client.Send(RequestMessage, ResponseMessage) then begin
            // post data

            //Read Response
            //ResponseMessage.Content.ReadAs(Response);


            //Handle the Response
            if ResponseMessage.IsSuccessStatusCode then begin
                FeedbackCode := ResponseMessage.HttpStatusCode;
                Response := ResponseMessage.ReasonPhrase;
                ResponseMessage.Content.ReadAs(Response);

                Message('Request Successful! Response: %1, %2. Posted Data: %3', Response, FeedbackCode, Content);
            end else
                Message('Request failed! %1', Response);
        end;


    END;




    procedure RSAEncryptedPayload(): Text
    var
        XmlString: Text;
        IncludePrivateParameters: Boolean;
        DataInStream: InStream;
        SignedDataInStream: InStream;
        HashAlgorithm: Enum "Hash Algorithm";
        SignatureOutStream: OutStream;
        SignatureInStream: InStream;
        PlainTextInStream: InStream;
        OaepPadding: Boolean;
        EncryptedTextOutStream: OutStream;

    begin
        XmlString := 'XML String of the Public Key Information';
        IncludePrivateParameters := false;
        //assign RSA signatures to instream and outstream
        RSAEncryption.ToXmlString(IncludePrivateParameters);
        DataInStream := PayloadJSONObject();
        RSAEncryption.SignData(XmlString, DataInStream, HashAlgorithm, SignatureOutStream);
        SignedDataInStream := DataInStream;
        if RSAEncryption.VerifyData(XmlString, SignedDataInStream, HashAlgorithm, SignatureInStream) = true then
            PlainTextInStream := SignedDataInStream;
        OaepPadding := true;
        //encryptedTextOutStream
        RSAEncryption.Encrypt(XmlString, PlainTextInStream, OaepPadding, EncryptedTextOutStream);


    end;


    procedure PayloadJSONObject(): InStream
    var
    begin


    end;



    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        Headers: HttpHeaders;
        RequestMessage: HttpRequestMessage;
        URL: Text;
        RSAEncryption: Codeunit RSACryptoServiceProvider;
        JsonOb: Codeunit "JSON Objects";
        Response: Text;
        FeedbackCode: Integer;
        EncryptedJSON: Codeunit RSATest;

}