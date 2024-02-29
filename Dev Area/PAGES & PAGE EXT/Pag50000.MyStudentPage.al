page 50000 MyStudentPage
{
    Caption = 'MyStudentPage';
    PageType = Card;
    SourceTable = MyStudentTable;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Reg No."; Rec."Reg No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reg No. field.';
                }
                field(course; Rec.course)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the course field.';
                }
                field(balance; Rec.balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the balance field.';
                    NotBlank = true;

                    ShowMandatory = TRUE;


                    //BALANCE CANNOT BE GREATER THAN 40000
                    trigger OnValidate()
                    var
                        debt: Integer;
                    begin
                        if (Rec.balance > 40000) then
                            Error('Balance cannot be greater than the required amount');
                        if (Rec.balance < 0) then begin
                            Debt := Rec.balance;
                            Message('The School Owes you: %1 ', debt);
                        end
                        else begin
                            Debt := 40000 - Rec.balance;
                            Message('Your School fee balance is: %1', Debt)

                        end;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("start date"; Rec."start date")
                {
                    ApplicationArea = all;
                }
                field("end date"; Rec."end date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

}
