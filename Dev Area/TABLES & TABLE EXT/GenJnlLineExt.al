tableextension 50017 GenJnlLineExtension extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
        }
        field(50002; Depth; Integer)
        {
            Caption = 'Depth';
            DataClassification = SystemMetadata;
        }
        field(50003; "Token type"; Option)
        {
            Caption = 'Token type';
            DataClassification = SystemMetadata;
            OptionCaption = 'None,Start Object,Start Array,Start Constructor,Property Name,Comment,Raw,Integer,Decimal,String,Boolean,Null,Undefined,End Object,End Array,End Constructor,Date,Bytes';
            OptionMembers = "None","Start Object","Start Array","Start Constructor","Property Name",Comment,Raw,"Integer",Decimal,String,Boolean,Null,Undefined,"End Object","End Array","End Constructor",Date,Bytes;
        }
        field(50004; Value; Text[250])
        {
            Caption = 'Value';
            DataClassification = SystemMetadata;
        }
        field(50005; "Value Type"; Text[50])
        {
            Caption = 'Value Type';
            DataClassification = SystemMetadata;
        }
        field(50006; Path; Text[250])
        {
            Caption = 'Path';
            DataClassification = SystemMetadata;
        }
        field(50007; "Value BLOB"; BLOB)
        {
            Caption = 'Value BLOB';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure ReadFromText(JSONText: Text)
    var
        JSONTextReader: DotNet JsonTextReader;
        StringReader: DotNet StringReader;
        TokenType: Integer;
        FormatValue: Integer;
    begin
        if not IsTemporary then
            Error(DevMsgNotTemporaryErr);
        DeleteAll();
        JSONTextReader := JSONTextReader.JsonTextReader(StringReader.StringReader(JSONText));
        if JSONTextReader.Read then
            repeat
                Init;
                "Entry No." += 1;
                Depth := JSONTextReader.Depth;
                TokenType := JSONTextReader.TokenType;
                "Token type" := TokenType;
                if IsNull(JSONTextReader.Value) then
                    Value := ''
                else begin
                    if JSONTextReader.ValueType.ToString() = 'System.DateTime' then
                        FormatValue := 1
                    else
                        FormatValue := 0;
                    SetValueWithoutModifying(Format(JSONTextReader.Value, 0, FormatValue));
                end;

                if IsNull(JSONTextReader.ValueType) then
                    "Value Type" := ''
                else
                    "Value Type" := Format(JSONTextReader.ValueType);
                Path := JSONTextReader.Path;
                Insert;
            until not JSONTextReader.Read;
    end;

    procedure SetValueWithoutModifying(NewValue: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Value BLOB");
        Value := CopyStr(NewValue, 1, MaxStrLen(Value));
        if StrLen(NewValue) <= MaxStrLen(Value) then
            exit; // No need to store anything in the blob
        if NewValue = '' then
            exit;

        "Value BLOB".CreateOutStream(OutStream, TEXTENCODING::Windows);
        OutStream.Write(NewValue);
    end;

    var
        DevMsgNotTemporaryErr: Label 'This function can only be used when the record is temporary.';

}