page 1369 "Monitored Fields Worksheet"
{
    PageType = Worksheet;
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;
    SourceTable = "Change Log Setup (Field)";
    Extensible = false;
    RefreshOnActivate = true;
    AccessByPermission = tabledata "Field Monitoring Setup" = m;
    Caption = 'Monitored Fields Worksheet';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(TableNo; TableNo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Table No.';
                    ToolTip = 'Specifies the identifier of the table that includes the monitored field.';

                    trigger OnValidate()
                    begin
                        MonitorSensitiveField.ValidateTableNo(TableNo);
                        SetTableNumberAndCaption();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AllObjWithCaption: Record AllObjWithCaption;
                    begin
                        MonitorSensitiveField.AddValidTablesFilter(AllObjWithCaption);

                        if Page.RunModal(Page::Objects, AllObjWithCaption) = ACTION::LookupOK then begin
                            TableNo := AllObjWithCaption."Object ID";
                            SetTableNumberAndCaption();
                        end;
                    end;
                }
                field("Table Caption"; "Table Caption")
                {
                    Caption = 'Table Caption';
                    ToolTip = 'Specifies the name of the table that includes the monitored field.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Field No"; "Field No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the identifier of the monitored field.';

                    trigger OnValidate()
                    begin
                        MonitorSensitiveField.ValidateTableAndFieldNo(TableNo, "Field No.");
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        FieldTable: Record Field;
                    begin
                        if TableNo <> 0 then
                            FieldTable.SetRange(TableNo, TableNo);
                        MonitorSensitiveField.AddAllowedFieldFilters(FieldTable);

                        if Page.RunModal(Page::"Fields Lookup", FieldTable) = Action::LookupOK then begin
                            TableNo := FieldTable.TableNo;
                            SetTableNumberAndCaption();
                            Validate("Field No.", FieldTable."No.");
                        end;
                    end;
                }
                field("Field Caption"; "Field Caption")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the name of the monitored field.';
                }
                field(Notify; Notify)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether to send an email notification when the value in this monitored field is changed. The email is sent to the recipient specified on the Field Monitoring Setup page.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add Fields")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Add fields';
                ToolTip = 'Choose the fields to monitor based on filter criteria, such as their data sensitivity classification.';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    MonitorSensitiveField.OpenDataSensitivityFilterPage();
                end;
            }
            action("Set Notification")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set for Notification';
                ToolTip = 'Turn on notifications for the selected fields.';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ChangeNotificationStatus(true);
                end;
            }
            action("Clear Notification")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Clear for  Notification';
                ToolTip = 'Turn off notification for the selected fields.';
                Image = ClearLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ChangeNotificationStatus(false);
                end;
            }
            action("Setup Monitor")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Field Monitoring Setup';
                ToolTip = 'Open the Field Monitoring Setup page.';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Field Monitoring Setup";
            }
            action("Changes Entries")
            {
                Caption = 'Field Change Entries';
                ToolTip = 'View a history of changes in monitored fields.';
                ApplicationArea = Basic, Suite;
                Image = Log;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Monitored Field Log Entries";
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        TableNo := 0;
        "Field No." := 0;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        MonitorSensitiveField.ValidateTableAndFieldNo("Table No.", "Field No.");
        MonitorSensitiveField.InsertChangeLogSetupTable(TableNo);
        SetTableNumberAndCaption();

        "Log Insertion" := true;
        "Log Modification" := true;
        "Log Deletion" := true;
        "Monitor Sensitive Field" := true;
    end;

    trigger OnAfterGetRecord()
    begin
        TableNo := "Table No.";
    end;

    local procedure ChangeNotificationStatus(NotifyValue: Boolean)
    begin
        CurrPage.SetSelectionFilter(Rec);

        if not IsEmpty() then
            ModifyAll(Notify, NotifyValue, true);
        Reset();
    end;

    local procedure SetTableNumberAndCaption()
    begin
        "Table No." := TableNo;
    end;

    var
        MonitorSensitiveField: Codeunit "Monitor Sensitive Field";
        TableNo: Integer;
}
