pageextension 8900 "Email Address Lookup" extends "Email Address Lookup"
{
    layout
    {
        addafter(EntityGroup)
        {
            group(JobResponsibleFilter)
            {
                Visible = EntityType = Enum::"Email Address Entity"::Contact;
                Caption = 'Contact filters';

                field(JobResponsible; JobSelection)
                {
                    ApplicationArea = All;
                    Caption = 'Job Responsibility';
                    ToolTip = 'A comma separated list of Job Responsibility codes.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        JobPage: Page "Job Responsibilities";
                        ContactNoFilter: Text;
                    begin
                        JobPage.Editable := false;
                        JobPage.LookupMode := true;
                        JobPage.HideNumberOfContactsField();
                        if JobPage.RunModal() <> Action::LookupOK then
                            exit;

                        JobPage.SetSelectionFilter(JobResponsibility);
                        ContactNoFilter := GetContactsFilter(JobResponsibility);

                        // Pretty print selection in text field
                        JobSelection := '';
                        if JobResponsibility.FindSet() then
                            repeat
                                JobSelection := JobSelection + JobResponsibility.Code + '|';
                            until JobResponsibility.Next() = 0;

                        if StrLen(JobSelection) > 0 then
                            JobSelection := JobSelection.TrimEnd('|');

                        if StrLen(ContactNoFilter) > 0 then begin
                            Rec.SetFilter("Contact No.", ContactNoFilter);
                            CurrPage.Update();
                        end;
                    end;

                    trigger OnValidate()
                    var
                        Filter: Text;
                    begin
                        if StrLen(JobSelection) = 0 then begin
                            JobResponsibility.Reset();
                            Rec.Reset();
                            CurrPage.Update();
                        end else begin
                            JobResponsibility.SetFilter(Code, JobSelection);
                            Filter := GetContactsFilter(JobResponsibility);

                            if StrLen(Filter) > 0 then begin
                                Rec.SetFilter("Contact No.", Filter);
                                CurrPage.Update();
                            end;
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        addbefore(Users)
        {
            action(Contacts)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                Caption = 'Contacts';
                ToolTip = 'Add addresses from Contacts.';
                Image = ContactPerson;

                trigger OnAction()
                begin
                    LookupFullAddressList(EntityType::Contact);
                end;

            }

            action(Customers)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                Caption = 'Customers';
                ToolTip = 'Add addresses from Customers.';
                Image = Customer;

                trigger OnAction()
                begin
                    LookupFullAddressList(EntityType::Customer);
                end;

            }

            action(Vendors)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                Caption = 'Vendors';
                ToolTip = 'Add addresses from Vendors.';
                Image = Vendor;

                trigger OnAction()
                begin
                    LookupFullAddressList(EntityType::Vendor);
                end;

            }

            action(Employees)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                Caption = 'Employees';
                ToolTip = 'Add addresses from Employees.';
                Image = Employee;

                trigger OnAction()
                begin
                    LookupFullAddressList(EntityType::Employee);
                end;
            }

        }
    }

    internal procedure GetContactsFilter(var Responsibility: Record "Job Responsibility"): Text
    var
        ContactResponsibility: Record "Contact Job Responsibility";
        SelectionFilterMgt: Codeunit SelectionFilterManagement;
        RecordRef: RecordRef;
        ResponsibilityFilter: Text;
    begin
        if Responsibility.IsEmpty() then
            exit('');

        RecordRef.GetTable(Responsibility);
        ResponsibilityFilter := SelectionFilterMgt.GetSelectionFilter(RecordRef, Responsibility.FieldNo(Code), false);

        ContactResponsibility.SetFilter("Job Responsibility Code", ResponsibilityFilter);
        if not ContactResponsibility.FindSet() then
            exit('');

        RecordRef.GetTable(ContactResponsibility);
        exit(SelectionFilterMgt.GetSelectionFilter(RecordRef, ContactResponsibility.FieldNo("Contact No."), false));
    end;

    var
        JobResponsibility: Record "Job Responsibility";
        JobSelection: Text;
}