page 1119 "Cost Budget by Cost Object"
{
    Caption = 'Cost Budget by Cost Object';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPlus;
    SourceTable = "Cost Type";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(RoundingFactor; RoundingFactor)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Rounding Factor';
                    ToolTip = 'Specifies the factor that is used to round the amounts in the columns.';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform;
                    end;
                }
                field(BudgetFilter; BudgetFilter)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Budget Filter';
                    TableRelation = "Cost Budget Name";
                    ToolTip = 'Specifies the budget name that you want to work on.';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform;
                    end;
                }
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'View by';
                    ToolTip = 'Specifies by which period amounts are displayed.';

                    trigger OnValidate()
                    begin
                        FindPeriod('');
                        UpdateMatrixSubform;
                    end;
                }
                field(AmountType; AmountType)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'View as';
                    ToolTip = 'Specifies how amounts are displayed. Net Change: The net change in the balance for the selected period. Balance at Date: The balance as of the last day in the selected period.';

                    trigger OnValidate()
                    begin
                        FindPeriod('');
                        UpdateMatrixSubform;
                    end;
                }
            }
            part(MatrixForm; "Cost Bdgt. per Object Matrix")
            {
                ApplicationArea = CostAccounting;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Budge&t")
            {
                Caption = 'Budge&t';
                Image = LedgerBudget;
                action("By &Period")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'By &Period';
                    Image = Calendar;
                    RunObject = Page "Cost Budget per Period";
                    RunPageOnRec = true;
                    ToolTip = 'View a summary of the amount budgeted in different time periods.';
                }
                action("By Cost &Center")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'By Cost &Center';
                    Image = CostCenter;
                    RunObject = Page "Cost Budget by Cost Center";
                    RunPageOnRec = true;
                    ToolTip = 'View a summary of the amount budgeted for each cost center in different time periods.';
                }
                separator(Action5)
                {
                }
                action("&Budget / Movement")
                {
                    ApplicationArea = CostAccounting;
                    Caption = '&Budget / Movement';
                    Image = CostBudget;
                    RunObject = Page "Cost Type Balance/Budget";
                    RunPageOnRec = true;
                    ToolTip = 'View a summary of the net changes and the budgeted amounts for different time periods for the cost type that you select in the chart of cost types.';
                }
            }
        }
        area(processing)
        {
            action(PreviousSet)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    GenerateColumnCaptions("Matrix Page Step Type"::Previous);
                    UpdateMatrixSubform;
                end;
            }
            action(PreviousColumn)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous column.';

                trigger OnAction()
                begin
                    GenerateColumnCaptions("Matrix Page Step Type"::PreviousColumn);
                    UpdateMatrixSubform;
                end;
            }
            action(NextColumn)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next column.';

                trigger OnAction()
                begin
                    GenerateColumnCaptions("Matrix Page Step Type"::NextColumn);
                    UpdateMatrixSubform;
                end;
            }
            action(NextSet)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    GenerateColumnCaptions("Matrix Page Step Type"::Next);
                    UpdateMatrixSubform;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        FindPeriod('');
        CostObjectMatrixRecord.SetCurrentKey("Sorting Order");
        MATRIX_CaptionFieldNo := 1;
        BudgetFilter := GetFilter("Budget Filter");
        GenerateColumnCaptions("Matrix Page Step Type"::Initial);
        UpdateMatrixSubform;
    end;

    var
        CostObjectMatrixRecords: array[12] of Record "Cost Object";
        CostObjectMatrixRecord: Record "Cost Object";
        MatrixMgt: Codeunit "Matrix Management";
        MatrixRecordRef: RecordRef;
        MATRIX_CaptionSet: array[12] of Text[80];
        MATRIX_CaptionRange: Text;
        MATRIX_PKFirstRecInCurrSet: Text;
        PeriodType: Enum "Analysis Period Type";
        RoundingFactor: Enum "Analysis Rounding Factor";
        AmountType: Enum "Analysis Amount Type";
        MATRIX_CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
        MATRIX_CurrSetLength: Integer;
        BudgetFilter: Code[10];

    local procedure GenerateColumnCaptions(StepType: Enum "Matrix Page Step Type")
    begin
        Clear(MATRIX_CaptionSet);
        Clear(CostObjectMatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        CostObjectMatrixRecord.SetRange("Line Type", CostObjectMatrixRecord."Line Type"::"Cost Object");
        if CostObjectMatrixRecord.Find('-') then;

        MatrixRecordRef.GetTable(CostObjectMatrixRecord);
        MatrixRecordRef.SetTable(CostObjectMatrixRecord);

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, StepType.AsInteger(), ArrayLen(CostObjectMatrixRecords), MATRIX_CaptionFieldNo,
          MATRIX_PKFirstRecInCurrSet, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CurrSetLength > 0 then begin
            CostObjectMatrixRecord.SetPosition(MATRIX_PKFirstRecInCurrSet);
            CostObjectMatrixRecord.Get(CostObjectMatrixRecord.Code);
            repeat
                CostObjectMatrixRecords[CurrentMatrixRecordOrdinal].Copy(CostObjectMatrixRecord);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (CostObjectMatrixRecord.Next <> 1);
        end;
    end;

    local procedure FindPeriod(FindTxt: Code[3])
    var
        Calendar: Record Date;
        PeriodPageMgt: Codeunit PeriodPageManagement;
    begin
        if GetFilter("Date Filter") <> '' then begin
            Calendar.SetFilter("Period Start", GetFilter("Date Filter"));
            if not PeriodPageMgt.FindDate('+', Calendar, PeriodType) then
                PeriodPageMgt.FindDate('+', Calendar, PeriodType::Day);
            Calendar.SetRange("Period Start");
        end;
        PeriodPageMgt.FindDate(FindTxt, Calendar, PeriodType);
        if AmountType = AmountType::"Net Change" then begin
            SetRange("Date Filter", Calendar."Period Start", Calendar."Period End");
            if GetRangeMin("Date Filter") = GetRangeMax("Date Filter") then
                SetRange("Date Filter", GetRangeMin("Date Filter"));
        end else
            SetRange("Date Filter", 0D, Calendar."Period End");
    end;

    local procedure UpdateMatrixSubform()
    begin
        CurrPage.MatrixForm.PAGE.LoadMatrix(
          MATRIX_CaptionSet, CostObjectMatrixRecords, MATRIX_CurrSetLength, GetFilter("Date Filter"), BudgetFilter, RoundingFactor);
    end;
}

