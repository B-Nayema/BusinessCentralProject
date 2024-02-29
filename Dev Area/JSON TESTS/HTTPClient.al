codeunit 50013 "Understanding HTTP Client"
{
    procedure HTTPClientTest(): Boolean
    var
        Client: HttpClient;
        Resp: HttpResponseMessage;
        URL: Text;
        Txt: Text;
        Int: Integer;
        Reason: Text;

    begin
        //URL := 'https://axess.sc.com/api/sbfunc/clientData/tryitout/payments/v2/initiate';
        URL := 'http://apitest.standardchartered.com//openapi/payments/v2/initiate';
        if Client.get(url, Resp) = true then begin
            Int := Resp.HttpStatusCode;
            Reason := Resp.ReasonPhrase;
            if Resp.IsSuccessStatusCode() then begin
                Resp.Content().ReadAs(Txt);
                Message(Txt);
            end
            else
                Error('Failed, Error: %1, Reason: %2!', Int, Reason);
            //exit(true);
        end;
        // exit(false);
    end;

    procedure clientPost()
    var
        client: HttpClient;
        RequestMessage: HttpRequestMessage;
        Headers: HttpHeaders;
        Content: HttpContent;
        Response: HttpResponseMessage;
        URL: Text;
        Txt: Text;
        Reason: Text;
        RsnCode: Integer;
        JsonOb: Codeunit "JSON Objects";
        IsSuccessful: Boolean;
    begin
        //URL := 'https://catfact.ninja/fact';
        URL := 'https://jsonplaceholder.typicode.com/todos';
        //URL := 'http://apitest.standardchartered.com//openapi/payments/v2/initiate';
        Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');
        RequestMessage.SetRequestUri(URL);
        RequestMessage.Method := 'POST';

        //CHECK IF IT IS BLOCKED BY API PROVIDERS
        if Response.IsBlockedByEnvironment = true
            then begin
            Message('Blocked by Environment');
            exit;
        END

        //POST THE DATA
        else begin

            content.GetHeaders(Headers);
            if headers.Contains('Content-Type') then Headers.Remove('Content-Type');
            headers.Add('Content-Type', 'Application/json');

            if headers.Contains('Content-Encoding') then Headers.Remove('Content-Encoding');
            headers.Add('Content-Encoding', 'UTF8');



            //Content.WriteFrom(JsonOb.GivenJson());
            IsSuccessful := client.Post(url, Content, Response);

            if not Response.IsSuccessStatusCode() then begin
                RsnCode := Response.HttpStatusCode;
                Reason := Response.ReasonPhrase;
                Message('Error! Response Code: %1! %2', RsnCode, Reason)
            end
            else
                response := ResponseProcedure();
        end;
    end;

    procedure ResponseProcedure(): HttpResponseMessage
    var
        client: HttpClient;
        RequestMessage: HttpRequestMessage;
        Headers: HttpHeaders;
        Content: HttpContent;
        Response: HttpResponseMessage;
        URL: Text;
        Txt: Text;
        Reason: Text;
        RsnCode: Integer;
        JsonOb: Codeunit "JSON Objects";
        IsSuccessful: Boolean;
    begin
        RsnCode := Response.HttpStatusCode;
        Reason := Response.ReasonPhrase;
        Message('Sucess! Response Code: %1! %2', RsnCode, Reason)

    end;

}