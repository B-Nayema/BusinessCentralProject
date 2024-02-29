pageextension 50003 CustomerList extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Customer")
        {
            action(ExportToXml)
            {

                caption = 'Export to XML';
                ApplicationArea = All;
                Image = XmlFile;

                trigger OnAction()

                begin
                    TempBlob.CreateOutStream(OutstreamVar);
                    CustomerXml.SetDestination(OutstreamVar);
                    CustomerXml.EXport();
                    TempBlob.CreateInStream(InStr);
                    FileName := 'Customers.xml';
                    File.DownloadFromStream(InStr, 'Download', '', '', FileName);


                end;
            }
        }
    }

    var
        TempBlob: Codeunit "Temp Blob";
        CustomerXml: XmlPort "Customer XML";
        OutstreamVar: OutStream;
        InStr: InStream;
        FileName: Text;

}