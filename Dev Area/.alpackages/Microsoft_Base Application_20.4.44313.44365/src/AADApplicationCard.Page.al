page 9861 "AAD Application Card"
{
    Caption = 'Azure Active Directory Application Card', Comment = 'Azure Active Directory Application should not be translated';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    RefreshOnActivate = true;
    SourceTable = "AAD Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Client Id"; "Client Id")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Standard;
                    Editable = EditableByNotEnabled;
                    Caption = 'Client ID';
                    ToolTip = 'Specifies the client ID for the app.';
                }
                field(Description; Description)
                {
                    ShowMandatory = true;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                    ToolTip = 'Specifies a description of the app. The description will be automatically added in the User Name field of the card the first time the app is enabled.';
                    Editable = EditableByNotEnabled;
                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field(State; State)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Standard;
                    Caption = 'State';
                    ToolTip = 'Specifies if the app is enabled or disabled.';
                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Contact Information"; "Contact Information")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = EditableByNotEnabled;
                    Caption = 'Contact Information';
                    ToolTip = 'Specifies the contact information of the app.';
                }
                group(Extension)
                {
                    field("App ID"; "App ID")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = EditableByNotEnabled;
                        Caption = 'App ID';
                        ToolTip = 'Specifies the app ID of the extension.';
                    }
                    field("App Name"; "App Name")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = EditableByNotEnabled;
                        Caption = 'App Name';
                        ToolTip = 'Specifies the app name of the extension.';
                    }
                }
                group("User information")
                {
                    field("User ID"; "User id")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                        Caption = 'User ID';
                        ToolTip = 'Specifies the unique ID (GUID) assigned to the application. This field is automatically filled in once the app is enabled. The user ID. like the user name, is used to indicate sessions and operations that are run by the app.';
                    }
                    field("User name"; Username)
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                        Caption = 'User Name';
                        ToolTip = 'Specifies the user name assigned to the app. This field is automatically filled in with the value of the Description field once the app is enabled. The user name, like the user ID, is used to indicate sessions and operations that are run by the app..';
                    }
                }
                field(ShowEnableWarning; ShowEnableWarning)
                {
                    ApplicationArea = Basic, Suite;
                    ShowCaption = false;
                    AssistEdit = false;
                    Editable = false;
                    Enabled = NOT EditableByNotEnabled;
                    trigger OnDrillDown()
                    begin
                        DrilldownCode();
                    end;
                }
            }

            part(UserGroups; "User Groups User SubPage")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Groups';
                Enabled = SetUserPermissionEnabled;
                SubPageLink = "User Security ID" = field("User ID");
                UpdatePropagation = Both;
            }
            part(Permissions; "User Subform")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Permission Sets';
                Enabled = SetUserPermissionEnabled;
                SubPageLink = "User Security ID" = field("User Id");
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action(Consent)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Grant Consent';
                Image = Setup;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Enabled = not IsVEApp;
                Scope = Repeater;
                ToolTip = 'Grant consent for this application to access data from Business Central.';


                trigger OnAction()

                begin
                    GrantConsent();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        AADApplicationSetup: Codeunit "AAD Application Setup";
    begin
        IsVEApp := LowerCase(GraphMgtGeneralTools.StripBrackets(Format(Rec."Client Id"))) = AADApplicationSetup.GetD365BCForVEAppId();
        UpdateControl();
    end;

    var
        GraphMgtGeneralTools: Codeunit "Graph Mgt - General Tools";
        CommonOAuthAuthorityUrlLbl: Label 'https://login.microsoftonline.com/common/adminconsent', Locked = true;
        ConsentFailedErr: Label 'Failed to give consent.';
        ConsentSuccessTxt: Label 'Consent was given successfully.';
        EnabledWarningTok: Label 'You must set the State field to Disabled before you can make changes to this app.';
        DisableEnableQst: Label 'Do you want to disable this app?';
        UserName: Text;
        ShowEnableWarning: Text;
        IsVEApp: Boolean;
        SetUserPermissionEnabled: Boolean;
        EditableByNotEnabled: Boolean;

    [NonDebuggable]
    [Scope('OnPrem')]
    local procedure GrantConsent();
    var
        OAuth2: Codeunit OAuth2;
        Success: Boolean;
        ErrorMsgTxt: Text;
    begin
        OAuth2.RequestClientCredentialsAdminPermissions(GraphMgtGeneralTools.StripBrackets(Format("Client Id")), CommonOAuthAuthorityUrlLbl, '', Success, ErrorMsgTxt);
        if not Success then
            if ErrorMsgTxt <> '' then
                Error(ErrorMsgTxt)
            else
                Error(ConsentFailedErr);
        Message(ConsentSuccessTxt);
        Rec."Permission Granted" := true;
        Rec.Modify();
    end;

    local procedure UpdateControl()
    var
        User: Record User;
    begin
        SetUserPermissionEnabled := true;
        if IsNullGuid(Rec."User ID") then
            SetUserPermissionEnabled := false;
        EditableByNotEnabled := Rec.State = Rec.State::Disabled;
        ShowEnableWarning := '';
        if CurrPage.Editable and (Rec.State = Rec.State::Enabled) then
            ShowEnableWarning := EnabledWarningTok;
        UserName := '';
        If User.Get("User Id") then
            UserName := USer."User Name";
    end;

    local procedure DrilldownCode()
    begin
        IF Confirm(DisableEnableQst, true) then begin
            Validate(Rec.State, Rec.State::Disabled);
            UpdateControl();
            CurrPage.Update();
        end;
    end;
}