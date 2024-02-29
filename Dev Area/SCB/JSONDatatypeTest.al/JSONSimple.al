codeunit 50012 "JSON Objects"
{
    procedure CreateSimpleJSON(): InStream
    begin
        JSONObject.Add('Item', '1000');
        Message(Format(JSONObject));
    end;

    procedure ComplicatedJson(): HttpContent
    var
        HeaderJsonObject: JsonObject;
        LineJsonObject: JsonObject;
        JSONArray: JsonArray;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        HeaderJsonObject.Add('Document Type', SalesHeader."Document Type".AsInteger());
        HeaderJsonObject.Add('No.', SalesHeader."No.");
        HeaderJsonObject.Add('SellToCustNo', SalesHeader."Sell-to Customer No.");
        HeaderJsonObject.Add('Posting Date', SalesHeader."Posting Date");

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                Clear(LineJsonObject);
                LineJsonObject.Add('Line No', SalesLine."Line No.");
                LineJsonObject.Add('Type', SalesLine.Type.AsInteger());
                LineJsonObject.Add('No', SalesLine."No.");
                LineJsonObject.Add('Quantity', SalesLine.Quantity);
                LineJsonObject.Add('UnitPrice', SalesLine."Unit Price");
                JSONArray.Add(LineJsonObject);
            until
            SalesLine.Next() = 0;
        HeaderJsonObject.Add('Lines', JSONArray);
        Message(Format(HeaderJsonObject));
    end;

    Procedure ReadComplexJSON(JsonString: Text)
    var
        Jsonresponse: JsonObject;
        JsonTokenValue: JsonToken;
        JsonOrder: JsonObject;


    begin
        if Jsonresponse.ReadFrom(JsonString) then begin
            Jsonresponse.Get('data', JsonTokenValue);

            JsonOrder := JsonTokenValue.AsObject();
            // JsonOrder.Get('DocumentType', JsonTokenType);
        end;
    end;


    Procedure GivenJson(): HttpContent
    begin
        JSONObject.Add('UserId', '1977');
        JSONObject.Add('Id', '1');
        JSONObject.Add('Title', 'Write Code Sample');
        JSONObject.Add('Completed', 'False');
        Message(Format(JSONObject));
    end;

    var
        JSONObject: JsonObject;
        JSONManagement: Codeunit "JSON Management";
}