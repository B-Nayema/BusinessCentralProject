xmlport 50004 GeneralJournalXMLPort
{
    Caption = 'GeneralJournalXMLPort';
    Format = VariableText;
    Direction = Import;
    UseRequestPage = false;
    TableSeparator = ',';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GenJournalLine; "Gen. Journal Line")
            {
                fieldelement(PostingDate; GenJournalLine."Posting Date")
                {
                }
                fieldelement(DocumentType; GenJournalLine."Document Type")
                {
                }
                fieldelement(DocumentNo; GenJournalLine."Document No.")
                {
                }
                fieldelement(AccountType; GenJournalLine."Account Type")
                {
                }
                fieldelement(AccountNo; GenJournalLine."Account No.")
                {
                }

                fieldelement(Description; GenJournalLine.Description)
                {
                }
                fieldelement(CurrencyCode; GenJournalLine."Currency Code")
                {
                }
                fieldelement(EU3PartyTrade; GenJournalLine."EU 3-Party Trade")
                {
                }
                fieldelement(GenPostingType; GenJournalLine."Gen. Posting Type")
                {
                }
                fieldelement(GenBusPostingGroup; GenJournalLine."Gen. Bus. Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; GenJournalLine."Gen. Prod. Posting Group")
                {
                }
                fieldelement(Amount; GenJournalLine.Amount)
                {
                }
                fieldelement(AmountLCY; GenJournalLine."Amount (LCY)")
                {
                }
                fieldelement(BalAccountType; GenJournalLine."Bal. Account Type")
                {
                }
                fieldelement(BalAccountNo; GenJournalLine."Bal. Account No.")
                {
                }
                fieldelement(BalGenPostingType; GenJournalLine."Bal. Gen. Posting Type")
                {
                }
                fieldelement(BalGenBusPostingGroup; GenJournalLine."Bal. Gen. Bus. Posting Group")
                {
                }
                fieldelement(BalGenProdPostingGroup; GenJournalLine."Bal. Gen. Prod. Posting Group")
                {
                }
                fieldelement(DeferralCode; GenJournalLine."Deferral Code")
                {
                }
                fieldelement(Correction; GenJournalLine.Correction)
                {
                }
                fieldelement(Comment; GenJournalLine.Comment)
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    IJL1: Record "Gen. Journal Line";
                    GenJnlTemplate: Record "Gen. Journal Template";
                    GenJnlBatch: Record "Gen. Journal Batch";
                    ImportCount: Integer;

                    LineNo: Integer;
                begin


                    IJL1.RESET;

                    GenJournalLine."Journal Template Name" := JournalTemplate;
                    GenJournalLine."Journal Batch Name" := JournalBatch;
                    GenJournalLine."Source Code" := SourceCode;
                    GenJournalLine."Reason Code" := ReasonCode;
                    GenJournalLine."Posting No. Series" := GenJnlBatch."Posting No. Series";

                    IJL1.SetRange("Journal Template Name", JournalTemplate);
                    IJL1.SetRange("Journal Batch Name", JournalBatch);

                    if IJL1.FINDLAST then
                        LineNo := IJL1."Line No." + 10000
                    else
                        LineNo := LineNo + 10000;
                    GenJournalLine."Line No." := LineNo;

                end;


            }

        }

    }
    procedure SetJournalTemplateBatch(Template: Code[20]; Batch: Code[20]; Source: Code[20]; Reason: Code[20])
    begin
        JournalTemplate := Template;
        JournalBatch := Batch;
        ReasonCode := Reason;
        SourceCode := Source;
    end;

    var
        JournalTemplate: Code[20];
        JournalBatch: Code[20];
        ReasonCode: Code[20];
        SourceCode: Code[20];


}
