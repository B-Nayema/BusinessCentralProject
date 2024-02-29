pageextension 50009 JournalExt extends "General Journal"
{

    actions
    {
        addafter("A&ccount")
        {
            action(ImportXML)
            {
                caption = 'My XMLPort';
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Import;
                ApplicationArea = all;
                trigger OnAction()
                var
                    GenJnlImport: XmlPort GeneralJournalXMLPort;
                begin
                    Clear(GenJnlImport);
                    GenJnlImport.SetJournalTemplateBatch(rec."Journal Template Name", rec."Journal Batch Name", rec."Source Code", rec."Reason Code");
                    GenJnlImport.Run();
                end;
            }
            action(EncryptXML)
            {
                caption = 'Encrypt File';
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Import;
                ApplicationArea = all;

                //RunObject = codeunit "ABSA Key";

                trigger OnAction()
                var


                begin

                    Xmlport.Run(50005, true, false);

                end;



            }

        }
    }

}
