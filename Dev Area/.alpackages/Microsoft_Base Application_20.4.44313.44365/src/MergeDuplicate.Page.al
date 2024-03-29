page 702 "Merge Duplicate"
{
    Caption = 'Merge Duplicate';
    DataCaptionExpression = "Table Name";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SaveValues = false;
    ShowFilter = false;
    SourceTable = "Merge Duplicates Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Records)
            {
                Caption = 'Records';
                Visible = NOT ShowRecID;
                group(Control15)
                {
                    InstructionalText = 'When merging, two records are combined into one.';
                    ShowCaption = false;
                }
                group(Control17)
                {
                    InstructionalText = 'Before merging, review which field values you want to keep or override. The merge action cannot be undone.';
                    ShowCaption = false;
                }
                field(Current; Current)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Duplicate; Duplicate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Merge With';

                    trigger OnValidate()
                    begin
                        ShowLines;
                    end;
                }
            }
            group("Conflicting Records")
            {
                Caption = 'Conflicting Records';
                InstructionalText = 'Before renaming or removing the conflicting record, review which field values you want to keep or override.';
                Visible = ShowRecID;
                group(Control18)
                {
                    InstructionalText = 'This action cannot be undone.';
                    ShowCaption = false;
                }
                field(CurrentRecID; GetPK("Current Record ID"))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Current';
                    Editable = false;
                    ToolTip = 'Specifies the values in the fields of the primary key of the current record.';
                }
                field(DuplicateRecID; GetPK("Duplicate Record ID"))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Conflicts With';
                    Editable = false;
                    ToolTip = 'Specifies the values in the fields of the primary key of the duplicate record.';
                }
            }
            group(Control9)
            {
                Caption = 'Conflicts';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                Visible = ConflictsExist;
                field(Conflicts; GetConflictsMsg)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the number of conflicts that prevent the merge.';

                    trigger OnDrillDown()
                    begin
                        ShowConflicts;
                        CurrPage.Update(false);
                    end;
                }
            }
            part("Fields"; "Merge Duplicate Subform")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Fields';
                ShowFilter = false;
            }
            part(Tables; "Merge Duplicate Subform")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Related Tables';
                Editable = false;
                ShowFilter = false;
                Visible = NOT ShowRecID;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Merge)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Merge';
                Image = ItemSubstitution;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Remove the duplicate record and reassign the related records to the current record.';
                Visible = NOT ShowRecID;

                trigger OnAction()
                begin
                    if Merge then begin
                        CurrPage.Close;
                        Message(RecordMergedMsg, "Table Name", Duplicate, Current);
                    end;
                end;
            }
            action("Remove Duplicate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Remove Duplicate';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Delete the duplicate record. Before you choose this action, select the Override checkbox for fields that are not in the primary key if you want to copy their values to the current record.';
                Visible = ShowRecID;

                trigger OnAction()
                begin
                    if RemoveConflictingRecord then begin
                        ConflictResolved := true;
                        CurrPage.Close;
                    end;
                end;
            }
            action("Rename Duplicate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Rename Duplicate';
                Ellipsis = true;
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Change values in the Alternate Value field on lines where it is the same as in the Current Value field. NOTE: This means that the duplicate record continues to exist after the merge.';
                Visible = ShowRecID;

                trigger OnAction()
                begin
                    if RenameConflictingRecord then begin
                        ConflictResolved := true;
                        CurrPage.Close;
                    end;
                end;
            }
        }
    }

    var
        RecordMergedMsg: Label '%1 %2 has been merged to %1 %3.', Comment = '%1 - table name (Customer/Vendor); %2 - Duplicate value; %3 - new kew value';
        ShowRecID: Boolean;
        ConflictResolved: Boolean;
        [InDataSet]
        ConflictsExist: Boolean;

    [Scope('OnPrem')]
    procedure IsConflictResolved(): Boolean
    begin
        exit(ConflictResolved);
    end;

    local procedure GetPK(RecordID: RecordID) PrimaryKey: Text
    begin
        PrimaryKey := Format(RecordID);
        PrimaryKey := CopyStr(PrimaryKey, StrPos(PrimaryKey, ': ') + 2);
    end;

    procedure Set(MergeDuplicatesBuffer: Record "Merge Duplicates Buffer")
    begin
        Rec := MergeDuplicatesBuffer;
        Insert;
        ShowRecID := false;
    end;

    procedure SetConflict(MergeDuplicatesConflict: Record "Merge Duplicates Conflict")
    begin
        InsertFromConflict(MergeDuplicatesConflict);
        ShowRecID := true;
        ShowLines;
    end;

    local procedure ShowLines()
    var
        TempMergeDuplicatesLineBuffer: Record "Merge Duplicates Line Buffer" temporary;
        TempMergeDuplicatesConflict: Record "Merge Duplicates Conflict" temporary;
    begin
        GetLines(TempMergeDuplicatesLineBuffer, TempMergeDuplicatesConflict);
        TempMergeDuplicatesLineBuffer.SetCurrentKey("In Primary Key");
        TempMergeDuplicatesLineBuffer.SetRange(Type, TempMergeDuplicatesLineBuffer.Type::Field);
        CurrPage.Fields.PAGE.Set(TempMergeDuplicatesLineBuffer);
        TempMergeDuplicatesLineBuffer.SetRange(Type, TempMergeDuplicatesLineBuffer.Type::Table);
        CurrPage.Tables.PAGE.Set(TempMergeDuplicatesLineBuffer);
        CurrPage.Update(true);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ConflictsExist := Rec.Conflicts > 0;
    end;
}

