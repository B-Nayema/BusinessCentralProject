
codeunit 50014 RSATest
{

    procedure TestRSA(): HttpContent
    var
        IncludePrivateParameters: Boolean;
        Xmlstring: Text;
        plaintextinstream: InStream;
        TextOutstream: OutStream;
    begin
        Xmlstring := 'C:\Users\Brian\SCBDemo.key';
        plaintextinstream := JSONObject.CreateSimpleJSON();
        //RSACrypto.ToXmlString(IncludePrivateParameters);
        RSACrypto.Encrypt(Xmlstring, plaintextinstream, FALSE, TextOutstream);


    end;

    var
        RSACrypto: Codeunit RSACryptoServiceProvider;
        JSONObject: Codeunit "JSON Objects";

}