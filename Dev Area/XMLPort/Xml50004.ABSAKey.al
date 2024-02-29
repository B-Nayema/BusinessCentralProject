xmlport 50005 ABSAKeyXML
{
    Caption = 'Export Encrypted Doc';
    Direction = Export;
    format = VariableText;


    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                }
                fieldelement(DocumentType; GenJournalLine."Document Type")
                {
                }
                fieldelement(PostingDate; GenJournalLine."Posting Date")
                {
                }
                fieldelement(CurrencyCode; GenJournalLine."Currency Code")
                {
                }
                fieldelement(Amount; GenJournalLine.Amount)
                {
                }
            }
        }
    }

    /* requestpage
    {


        actions
        {
            area(processing)
            {
                action(EncryptFile)
                {
                    Caption = 'Encrypt ABSA';
                    ApplicationArea = all;
                    ToolTip = 'Click to Run';
                    RunObject = codeunit "ABSA Key";
                }
            }
        }
    }*/






}
