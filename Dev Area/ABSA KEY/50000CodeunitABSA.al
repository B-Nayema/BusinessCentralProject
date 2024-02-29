//DOTNET DECLARATIONS

dotnet
{


    assembly("BouncyCastle.Crypto")
    {
        type(Org.BouncyCastle.Bcpg.OpenPgp.PgpSignature; BoucySign)
        {

        }

    }
    assembly("SecurePGP")
    {
        type(Secure.PGP.SecurePGPEncryptDecrypt; SecurePGP2)
        {

        }


    }

}
codeunit 50011 EventPublishers
{
    [IntegrationEvent(false, false)]
    procedure OnEncryptFile(InputFile: Text[200])
    begin

    end;

}
codeunit 50009 "ABSA Key"
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::EventPublishers, 'OnEncryptFile', '', true, true)]
    procedure EncryptFile(InputFile: Text[200])

    var

        OutputFile: Text[200];
        CompInfo: Record "Company Information";
        SecurePGP2: DotNet SecurePGP2;
        BouncySign: DotNet BoucySign;


    begin



        CompInfo.GET;
        CompInfo.TESTFIELD("Public Key File");
        CompInfo.TESTFIELD("Private Key File");

        InputFile := 'C:\Users\Brian\Downloads\' + InputFile;
        OutputFile := InputFile + '_signed' + '.pgp';

        IF ISNULL(SecurePGP2) THEN
            SecurePGP2 := SecurePGP2.SecurePGPEncryptDecrypt;

        // SecurePGP2.SignFile(string inputFilePath, string outputFilePath, string publicKeyFilePath, string privateKeyFilePath, string passPhrase, bool armor, bool withIntegrityCheck)
        // SecurePGP2.SignFile(InputFile,'C:\ACH\ABPY00004_signed.pgp',CompInfo."Public Key File",CompInfo."Private Key File",CompInfo.PassPhrase,TRUE,FALSE);
        SecurePGP2.SignFile(InputFile, OutputFile, CompInfo."Public Key File", CompInfo."Private Key File", CompInfo.PassPhrase, TRUE, FALSE);

        //Delete main file
        FILE.ERASE(InputFile);
        Download(OutputFile, 'File Exported', '', '', OutputFile);

        MESSAGE('File Exported and Signed');

    end;


}