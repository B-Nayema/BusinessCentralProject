table 9651 "Report Layout Selection"
{
    Caption = 'Report Layout Selection';
    DataPerCompany = false;

    fields
    {
        field(1; "Report ID"; Integer)
        {
            Caption = 'Report ID';
        }
        field(2; "Report Name"; Text[80])
        {
            Caption = 'Report Name';
            Editable = false;
        }
        field(3; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company;
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'RDLC,Word,Custom Layout,Excel,External';
            OptionMembers = "RDLC (built-in)","Word (built-in)","Custom Layout","Excel Layout","External Layout";

            trigger OnValidate()
            begin
                TestField("Report ID");
                CalcFields("Report Caption");
                "Report Name" := "Report Caption";
                case Type of
                    Type::"RDLC (built-in)":
                        begin
                            if not HasRdlcLayout("Report ID") then
                                Error(NoRdlcLayoutErr, "Report Name");
                            "Custom Report Layout Code" := '';
                        end;
                    Type::"Word (built-in)":
                        begin
                            if not HasWordLayout("Report ID") then
                                Error(NoWordLayoutErr, "Report Name");
                            "Custom Report Layout Code" := '';
                        end;
                    Type::"Excel Layout":
                        begin
                            if not HasExcelLayout("Report ID") then
                                Error(NoExcelLayoutErr, "Report Name");
                            "Custom Report Layout Code" := '';
                        end;
                    Type::"External Layout":
                        begin
                            if not HasExternalLayout("Report ID") then
                                Error(NoExternalLayoutErr, "Report Name");
                            "Custom Report Layout Code" := '';
                        end;
                end;
            end;
        }
        field(6; "Custom Report Layout Code"; Code[20])
        {
            Caption = 'Custom Report Layout Code';
            TableRelation = "Custom Report Layout" WHERE("Report ID" = FIELD("Report ID"));

            trigger OnValidate()
            begin
                if "Custom Report Layout Code" = '' then
                    Type := GetDefaultType("Report ID")
                else
                    Type := Type::"Custom Layout";
            end;
        }
        field(7; "Report Layout Description"; Text[250])
        {
            CalcFormula = Lookup("Custom Report Layout".Description WHERE(Code = FIELD("Custom Report Layout Code")));
            Caption = 'Report Layout Description';
            FieldClass = FlowField;
        }
        field(8; "Report Caption"; Text[80])
        {
            CalcFormula = Lookup("Report Metadata".Caption WHERE(ID = FIELD("Report ID")));
            Caption = 'Report Caption';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Report ID", "Company Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField("Report ID");
        if "Company Name" = '' then
            "Company Name" := CompanyName;
    end;

    var
        NoRdlcLayoutErr: Label 'Report ''%1'' has no RDLC layout.', Comment = '%1=a report name';
        NoWordLayoutErr: Label 'Report ''%1'' has no Word layout.', Comment = '%1=a report name';
        NoExcelLayoutErr: Label 'Report ''%1'' has no Excel layout.', Comment = '%1=a report name';
        NoExternalLayoutErr: Label 'Report ''%1'' has no External layout.', Comment = '%1=a report name';

    procedure GetDefaultType(ReportID: Integer): Integer
    var
        reportDefaultLayout: DefaultLayout;
    begin
        reportDefaultLayout := REPORT.DefaultLayout(ReportID);

        case reportDefaultLayout of
            DEFAULTLAYOUT::Word:
                exit(Type::"Word (built-in)");
            DefaultLayout::Excel:
                exit(Type::"Excel Layout");
            DefaultLayout::RDLC:
                exit(Type::"RDLC (built-in)");
            DefaultLayout::None:
                exit(Type::"RDLC (built-in)");
        end;
    end;

    procedure IsProcessingOnly(ReportID: Integer): Boolean
    begin
        exit(REPORT.DefaultLayout(ReportID) = DEFAULTLAYOUT::None);
    end;

    local procedure HasRdlcLayout(ReportID: Integer): Boolean
    var
        ReportLayoutList: Record "Report Layout List";
    begin
        ReportLayoutList.SetFilter("Report ID", '=%1', ReportID);
        ReportLayoutList.SetFilter("Layout Format", '=%1', ReportLayoutList."Layout Format"::RDLC);
        exit(not ReportLayoutList.IsEmpty());
    end;

    procedure HasWordLayout(ReportID: Integer): Boolean
    var
        ReportLayoutList: Record "Report Layout List";
    begin
        ReportLayoutList.SetFilter("Report ID", '=%1', ReportID);
        ReportLayoutList.SetFilter("Layout Format", '=%1', ReportLayoutList."Layout Format"::Word);
        exit(not ReportLayoutList.IsEmpty());
    end;

    local procedure HasExcelLayout(ReportID: Integer): Boolean
    var
        ReportLayoutList: Record "Report Layout List";
    begin
        ReportLayoutList.SetFilter("Report ID", '=%1', ReportID);
        ReportLayoutList.SetFilter("Layout Format", '=%1', ReportLayoutList."Layout Format"::Excel);
        exit(not ReportLayoutList.IsEmpty());
    end;

    local procedure HasExternalLayout(ReportID: Integer): Boolean
    var
        ReportLayoutList: Record "Report Layout List";
    begin
        ReportLayoutList.SetFilter("Report ID", '=%1', ReportID);
        ReportLayoutList.SetFilter("Layout Format", '=%1', ReportLayoutList."Layout Format"::Custom);
        exit(not ReportLayoutList.IsEmpty());
    end;

    procedure HasCustomLayout(ReportID: Integer): Integer
    var
        CustomReportLayout: Record "Custom Report Layout";
    begin
        // Temporarily selected layout for Design-time report execution?
        if GetTempLayoutSelected <> '' then
            if CustomReportLayout.Get(GetTempLayoutSelected) then begin
                if CustomReportLayout.Type = CustomReportLayout.Type::RDLC then
                    exit(1);
                exit(2);
            end;

        // Normal selection
        exit(HasNormalCustomLayoutSelection(ReportID));
    end;

    procedure SelectedBuiltinLayoutType(ReportID: Integer): Integer
    begin
        if not Get(ReportID, CompanyName) then
            exit(0);
        case Type of
            Type::"RDLC (built-in)":
                exit(1);
            Type::"Word (built-in)":
                exit(2);
            Type::"Excel Layout":
                exit(3);
            Type::"External Layout":
                exit(4);
            else
                exit(0);
        end;
    end;

    local procedure HasNormalCustomLayoutSelection(ReportID: Integer) Result: Integer
    var
        CustomReportLayout: Record "Custom Report Layout";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeHasNormalCustomLayoutSelection(ReportID, Result, IsHandled);
        if IsHandled then
            exit;

        if not Get(ReportID, CompanyName) then
            exit(0);
        case Type of
            Type::"Custom Layout":
                begin
                    if not CustomReportLayout.Get("Custom Report Layout Code") then
                        exit(0);
                    if CustomReportLayout.Type = CustomReportLayout.Type::RDLC then
                        exit(1);
                    if CustomReportLayout.Type = CustomReportLayout.Type::Word then
                        exit(2);
                end;
            else
                exit(0);
        end;
    end;

    procedure GetTempLayoutSelected(): Code[20]
    var
        DesignTimeReportSelection: Codeunit "Design-time Report Selection";
    begin
        exit(DesignTimeReportSelection.GetSelectedCustomLayout);
    end;

    procedure SetTempLayoutSelected(NewTempSelectedLayoutCode: Code[20])
    var
        DesignTimeReportSelection: Codeunit "Design-time Report Selection";
    begin
        DesignTimeReportSelection.SetSelectedCustomLayout(NewTempSelectedLayoutCode);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeHasNormalCustomLayoutSelection(ReportID: Integer; var Result: Integer; var Handled: Boolean)
    begin
    end;
}

