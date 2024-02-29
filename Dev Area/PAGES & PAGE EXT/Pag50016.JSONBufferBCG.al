page 50016 "JSON Buffer BCG"
{
    Caption = 'JSON Buffer BCG';
    PageType = List;
    SourceTable = "JSON Buffer";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(Depth; Rec.Depth)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Depth field.';
                }
                field(Path; Rec.Path)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Path field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Token type"; Rec."Token type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Token type field.';
                }
                field("Value"; Rec."Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Value field.';
                }
                field("Value BLOB"; Rec."Value BLOB")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Value BLOB field.';
                }
                field("Value Type"; Rec."Value Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Value Type field.';
                }
            }
        }
    }
}
