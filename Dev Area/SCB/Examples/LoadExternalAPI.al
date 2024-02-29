dotnet
{
    assembly(mscorlib)
    {
        type(System.Text.StringBuilder; StringBuilder)
        {

        }
        type(System.IO.StringWriter; StringWriter)
        {

        }
        type(System.IO.StringReader; StringReader)
        {

        }
        type(System.Security.Cryptography.HMACSHA256; HMACSHA256)
        {

        }
        type(System."Byte[]"; SystemByte)
        {

        }


    }

    assembly(mscorlib)
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        type(System.String; Json)
        {

        }
    }
    /*  assembly(Newtonsoft.Json)
     {
         Version = '6.0.0.0';
         Culture = 'Neutral';
          type(Newtonsoft.Json.JsonTextWriter; JsonTextWriter)
         {

         } 
         type(Newtonsoft.Json.JsonTextReader; JsonTextReader)
         {

         }

     } */
}
codeunit 50006 LearningAPI
{
    procedure Initialize()
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);

    end;

    procedure StartJson(WriteStartObject: DotNet JsonTextWriter)
    begin
        Initialize();
        WriteStartObject := WriteStartObject;
    end;

    procedure AddToJson()
    BEGIN


    END;


    var
        StringBuilder: DotNet StringBuilder;
        StringWriter: Dotnet StringWriter;
        StringReader: DotNet StringReader;
        JsonTextWriter: DotNet JsonTextWriter;



}