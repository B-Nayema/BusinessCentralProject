page 1506 "Workflow Event Hierarchies"
{
    ApplicationArea = Suite;
    Caption = 'Workflow Event Hierarchies';
    PageType = ListPlus;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            part(MatrixEventSubpage; "WF Event/Event Comb. Matrix")
            {
                ApplicationArea = Suite;
                Caption = 'Supported Events';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PreviousSet)
            {
                ApplicationArea = Suite;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    SetColumns("Matrix Page Step Type"::Previous);
                end;
            }
            action(NextSet)
            {
                ApplicationArea = Suite;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    SetColumns("Matrix Page Step Type"::Next);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetColumns("Matrix Page Step Type"::Initial);
    end;

    var
        MatrixManagement: Codeunit "Matrix Management";
        ColumnSetEvents: Text;
        MATRIX_ColumnCaptions_Events: array[12] of Text[80];
        PKFirstRecInCurrSetEvents: Text;
        ColumnSetLengthEvents: Integer;

    local procedure SetColumns(StepType: Enum "Matrix Page Step Type")
    var
        WorkflowEvent: Record "Workflow Event";
        EventRecRef: RecordRef;
    begin
        EventRecRef.Open(DATABASE::"Workflow Event");
        MatrixManagement.GenerateMatrixData(
            EventRecRef, StepType.AsInteger(), ArrayLen(MATRIX_ColumnCaptions_Events),
            WorkflowEvent.FieldNo(Description), PKFirstRecInCurrSetEvents, MATRIX_ColumnCaptions_Events,
            ColumnSetEvents, ColumnSetLengthEvents);

        CurrPage.MatrixEventSubpage.PAGE.SetMatrixColumns(MATRIX_ColumnCaptions_Events, ColumnSetLengthEvents);
        CurrPage.Update(false);
    end;
}

