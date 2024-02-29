dotnet
{


}



codeunit 50016 CreateJWTTest
{
    Procedure OnRun(): Text
    begin
        SecretKey := ReadPrivateKey(SecretKey);
        // Message(CryptographyManagement.GenerateHash(CreateJSON(), SecretKey, HashAlgo::HMACSHA256));
        //Message(CryptographyManagement.GenerateBase64KeyedHash(CreateJSON(), privatekey."Private Key File", HashAlgorithmType::MD5));

    end;

    procedure CreateJSON(): Text
    var
        Input1: Text;
        Input2: Text;
        BASE64Input1: Text;
        Base64Input2: Text;
        Input3: Text;
        Output1: Text;
        HMACsha256: DotNet HMACSHA256;
        Crypto1: DotNet HMACSHA256;
        Output2: Text;
        Output3: Text;

    begin
        header.add('alg', 'HS256');
        Header.Add('typ', 'JWT');
        Payload.Add('Sub', '08012024');
        Payload.Add('Name', 'John Doe');
        payload.Add('issuer', 'BCD365');

        Header.WriteTo(Input1);
        Payload.WriteTo(Input2);
        Input3 := Input1 + Input2;
        BASE64Input1 := Base64Convert.ToBase64(Input1);
        Base64Input2 := Base64Convert.ToBase64(Input2);
        //Output1 := Base64Convert.ToBase64(Input3);
        Output1 := BASE64Input1 + '.' + Base64Input2;
        Output2 := Base64Convert.ToBase64(Output1);


        SecretKey := ReadPrivateKey(SecretKey);
        Output3 := Base64Convert.ToBase64(Crypto.GenerateHash(Output1, SecretKey, HashAlgorithmType::HMACSHA256));
        signature := Crypto.GenerateHash(Output2, SecretKey, HashAlgorithmType::HMACSHA256);
        Message(BASE64Input1 + '.' + Base64Input2 + '.' + Output3);
        exit(signature);

    end;


    procedure FinalExample(): Text
    var

    begin
        SecretKey := ReadPrivateKey(SecretKey);
        //Base64Output := Base64Convert.ToBase64(CreateJSON());
        signature := Crypto.GenerateBase64KeyedHashAsBase64String(Base64Output, SecretKey, HashAlgo::HMACSHA256);

        Message(signature);
    end;

    procedure ReadPrivateKey(String: Text[500]): Text
    var
        Testfile: File;
        varSize: Integer;
    begin
        TestFile.Open('C:\Users\Brian\PEM File\SCBDemo_Public.key');
        varSize := TestFile.Read(String);
        exit(String);
        //Message('The text "%1" is %2 bytes.', String, varSize);
    end;

    procedure GetSignature(Uri: Text; keyName: Text; keyText: Text; ttl: Duration): Text

    var

        Crypto: Codeunit "Cryptography Management";

        TypeHelper: Codeunit "Type Helper";

        expiry: Text;

        stringToSign: Text;

        signature: Text;

        HashAlgo: Option HMACMD5,HMACSHA1,HMACSHA256,HMACSHA384,HMACSHA512;

    begin

        //expiry := GetExpiry(ttl);

        stringToSign := TypeHelper.UrlEncode(Uri) + '\' + 'n' + expiry;

        signature := Crypto.GenerateBase64KeyedHashAsBase64String(stringToSign, keyText, HashAlgo::HMACSHA256);

        exit(signature);

    end;



    var


        Header: JsonObject;
        Payload: JsonObject;
        CryptographyManagement: Codeunit "Cryptography Management";
        HashAlgorithmType: Option HMACSHA256,MD5,SHA1,SHA384,SHA512;
        privatekey: Record "Company Information";
        SecretKey: Text;
        HashAlgo: Option HMACMD5,HMACSHA1,HMACSHA256,HMACSHA384,HMACSHA512;
        Base64Convert: Codeunit "Base64 Convert";
        Crypto: Codeunit "Cryptography Management";
        signature: Text;



        Base64Output: Text;

}