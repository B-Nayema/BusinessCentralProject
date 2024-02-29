page 50001 RegisterPage
{
    AdditionalSearchTerms = 'general ledger registers';
    ApplicationArea = Basic, Suite;
    Caption = 'Register';
    Editable = false;
    PageType = List;
    SourceTable = MyStudentTable;
    SourceTableView = SORTING("Reg No.")
                      ORDER(Descending);
    UsageCategory = History;
    PromotedActionCategories = 'New,Process,Report,Reverse';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Reg No."; Rec."Reg No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reg No. field.';
                }
                field(name; Rec.name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the name field.';
                }
                field("start date"; Rec."start date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the start date field.';
                }
                field("end date"; Rec."end date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the end date field.';
                }
            }
        }
    }
    /*local procedure CopyRows()
    var
        from: Record MyStudentTable;
        yo: Record Register;
    begin
        if from.Find() then
            repeat
                yo."start date" := from."start date";
                yo."end date" := from."end date";
                yo."Reg No." := from."Reg No.";
                yo.name := from.name;
                yo.Insert();
            until from.Next() = 0;
    end;*/
}
