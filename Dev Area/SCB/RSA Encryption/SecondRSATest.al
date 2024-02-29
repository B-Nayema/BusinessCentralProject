dotnet
{
    assembly(mscorlib)
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';
        type(System.Security.Cryptography.RSACryptoServiceProvider; RSA1)
        {

        }
        type(System.IO.StreamReader; reader)
        {

        }
        type(System.Security.Cryptography.RSAParameters; RSAParameters)
        {

        }

    }
    assembly("BouncyCastle.Crypto")
    {
        type(Org.BouncyCastle.OpenSsl.PemReader; PemReader)
        {

        }
        type(Org.BouncyCastle.Crypto.AsymmetricCipherKeyPair; KeyPair)
        {

        }
        type(Org.BouncyCastle.Security.DotNetUtilities; DotNetUtilities)
        {

        }
        type(Org.BouncyCastle.Crypto.Parameters.RsaKeyParameters; RsaKeyParameters)
        {

        }
        type(Org.BouncyCastle.Crypto.Parameters.RsaPrivateCrtKeyParameters; RSAPrivateParameters)
        {

        }
    }
}
codeunit 50015 SecondRSATest
{
    trigger OnRun()
    var
        RSAcspPri: DotNet RSA1;
        RSAcspPub: DotNet RSA1;
        Txt2Encrypt: Text;
        TxtEncrypted: Text;
        TxtDecrypted: Text;
        Path2PEMFile: Text;
    begin
        RSAcspPri := RSAcspPri.RSACryptoServiceProvider();
        Path2PEMFile := 'C:\Users\Brian\PEM File';

    end;

    procedure ReadPEM(FilePath: Text; Type: Option Private,Public; RSAcsp: DotNet RSA1)
    var
        FileMgt: Codeunit 419;
        ServerFile: Text;
        Pemreader: DotNet PemReader;
        Keypair: DotNet KeyPair;
        DotnetUtilities: DotNet DotNetUtilities;
        reader: DotNet reader;
        RSAKeyParameters: dotnet RsaKeyParameters;
        RSAPrivateParameters: dotnet RSAPrivateParameters;
        RSAParameters: DotNet RSAParameters;
        Delete: Codeunit "Cryptography Management";
    begin
        ServerFile := FileMgt.ServerTempFileName('');
        ServerFile := FileMgt.UploadFile(FilePath, ServerFile);
        reader := reader.StreamReader(ServerFile);
        //PemReader := PemReader.PemReader(reader);
        KeyPair := PemReader.ReadObject();
        IF Type = Type::Private THEN BEGIN
            RSAPrivateParameters := KeyPair.Private;
            RSAParameters := DotNetUtilities.ToRSAParameters(RSAPrivateParameters);
        END ELSE BEGIN
            // RSAKeyParameters := KeyPair;
            RSAParameters := DotNetUtilities.ToRSAParameters(RSAKeyParameters);
            Delete.EnableEncryption(true);

        END;
        RSAcsp.ImportParameters(RSAParameters);

    end;

    var
        Json: JsonToken;


}