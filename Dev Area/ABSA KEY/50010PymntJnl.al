pageextension 50011 PayJnl extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Line")
        {
            action(EncryptFile)
            {
                caption = 'Encrypt & Sign';
                Promoted = true;
                Visible = true;
                Enabled = true;
                RunPageMode = Edit;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = EncryptionKeys;
                ApplicationArea = all;
                Scope = Page;
                Ellipsis = false;
                RunPageOnRec = false;
                InFooterBar = false;

                trigger OnAction()
                var

                    Publisher: Codeunit EventPublishers;
                    TempFile: File;
                    NewStream: InsTream;


                begin



                    TempFile.CreateTempFile();
                    //TempFile.Write('abc');

                    TempFile.CreateInStream(NewStream);

                    //InputFile := 'Encrypt Decrypt.txt';
                    //DownloadFromStream(NewStream, 'Export', '', 'All Files (*.*)|*.*', InputFile);
                    UploadIntoStream('Select File..', '', '', InputFile, NewStream);
                    Publisher.OnEncryptFile(InputFile);
                end;
            }
        }
    }

    var
        InputFile: Text[200];
        Delete: Report "Aged Accounts Payable";


}