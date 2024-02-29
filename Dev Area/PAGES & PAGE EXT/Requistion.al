page 50010 "Requisition Issue Archive"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Requisition Issue Archive';
    PageType = List;
    SourceTable = "Item Line Archive";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }

                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchase Requisition No."; Rec."Purchase Requisition No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchase Requisition Line No."; Rec."Purchase Requisition Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Fund No."; Rec."Fund No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty Issued"; Rec."Qty Issued")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty Remaining"; Rec."Qty Remaining")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Dimension Speedkey Code"; Rec."Dimension Speedkey Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issue to Fund"; Rec."Issue to Fund")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Owner ID"; Rec."Owner ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Post to Journal")
                {
                    ApplicationArea = All;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        Sourcecodesetup.GET();
                        PurchSetup.GET();


                        IF CONFIRM('Do you want to post the requisition to the journal?') THEN BEGIN
                            ReQline.RESET;
                            //tbl

                            ReQline.SETRANGE(ReQline.Select, TRUE);
                            //ReQline.SETRANGE("Qty Remaining", 0);
                            IF ReQline.FIND('-') THEN
                                ERROR('You can not Send to journal when quantity remaining is zero,Requisition No. %1, Line No. %2',
                                ReQline."Purchase Requisition No.", ReQline."Purchase Requisition Line No.");


                            ReQline.RESET;
                            ReQline.SETRANGE(ReQline.Select, TRUE);
                            IF ReQline.FIND('-') THEN BEGIN

                                REPEAT
                                /*   //code here
                                  whseEmp.RESET;
                                  whseEmp.SETRANGE(whseEmp."User ID", UPPERCASE(USERID));
                                  //whseEmp.SETRANGE(whseEmp."Location Code", "Location Code");
                                  //whseEmp.SETRANGE(whseEmp.Supervisor,TRUE);
                                  IF NOT whseEmp.FIND('-') THEN
                                      ERROR('You are not allowed to process data coded to another Location. You must be an employee of this Location');
                                  itemJnlLine.INIT;
                                  itemJnlLine.RESET;
                                  itemJnlLine.SETRANGE(itemJnlLine."Journal Template Name", PurchSetup."Inventory Fulfill Template");

                                  itemJnlLine.SETRANGE(itemJnlLine."Journal Batch Name", PurchSetup."Inventory Fulfill Batch");
                                  IF itemJnlLine.FINDLAST() THEN
                                      lineNo := itemJnlLine."Line No." + 10000;

                                  itemJnlLine.INIT;
                                  //itemJnlLine."Status NVG" := itemJnlLine."Status NVG"::Approved;
                                  itemJnlLine."Journal Template Name" := PurchSetup."Inventory Fulfill Template";
                                  itemJnlLine."Journal Batch Name" := PurchSetup."Inventory Fulfill Batch";
                                  itemJnlLine."Line No." := lineNo;
                                  itemJnlLine."Source Code" := Sourcecodesetup."Item Journal";
                                  itemJnlLine.VALIDATE(itemJnlLine."Source Code");
                                  itemJnlLine.VALIDATE("Item No.", ReQline."Item No.");
                                  itemJnlLine."Posting Date" := TODAY;
                                  itemJnlLine."Entry Type" := itemJnlLine."Entry Type"::Sale;
                                  itemJnlLine."Document No." := ReQline."Document No.";
                                  itemJnlLine.Description := ReQline.Description;
                                  itemJnlLine."Location Code" := ReQline."Location Code";
                                  //KWT 08March2015
                                  IF InventorySetup.GET THEN
                                      itemJnlLine."Fund No. NVG" := InventorySetup."Default Inventory Fund";
                                  //end 08March2015
                                  itemJnlLine."Purchase Requisition No. NVG" := ReQline."Purchase Requisition No.";
                                  itemJnlLine."Purchase RequisitionLineNo NVG" := ReQline."Purchase Requisition Line No.";
                                  itemJnlLine."Purchaser Code" := ReQline."Purchaser Code";
                                  itemJnlLine."Issue to Fund" := ReQline."Fund No.";
                                  itemJnlLine.VALIDATE("Fund No. NVG");
                                  itemJnlLine.VALIDATE(itemJnlLine."Unit of Measure Code", ReQline."Unit of Measure Code");
                                  //tbl kwt 09Feb2015
                                  itemJnlLine.VALIDATE("Requisition Qty Requested", ReQline."Qty Remaining");
                                  //end
                                  itemJnlLine.VALIDATE(itemJnlLine.Quantity, ReQline."Qty Remaining");
                                  itemJnlLine.VALIDATE(itemJnlLine."Unit Cost", ReQline."Unit Cost");
                                  itemJnlLine.VALIDATE(itemJnlLine."Unit Amount");
                                  itemJnlLine.VALIDATE(itemJnlLine."Shortcut Dimension 1 Code", ReQline."Shortcut Dimension 1 Code");
                                  itemJnlLine.VALIDATE(itemJnlLine."Shortcut Dimension 2 Code", ReQline."Shortcut Dimension 2 Code");
                                  itemJnlLine.VALIDATE(itemJnlLine."Shortcut Dimension 3 Code NVG", ReQline."Shortcut Dimension 3 Code");
                                  itemJnlLine.VALIDATE(itemJnlLine."Shortcut Dimension 4 Code NVG", ReQline."Shortcut Dimension 4 Code");
                                  itemJnlLine.VALIDATE(itemJnlLine."Shortcut Dimension 5 Code NVG", ReQline."Shortcut Dimension 5 Code");
                                  itemJnlLine.VALIDATE(itemJnlLine."Shortcut Dimension 6 Code NVG", ReQline."Shortcut Dimension 6 Code");
                                  itemJnlLine.VALIDATE(itemJnlLine."Shortcut Dimension 7 Code NVG", ReQline."Shortcut Dimension 7 Code");

                                  itemJnlLine."Document Date" := ReQline."Document Date";
                                  itemJnlLine."Document Post Status NVG" := TRUE;

                                  IF itemJnlLine.Quantity <> 0 THEN
                                      itemJnlLine.INSERT;

                                  //tbl
                                  ReQline.Select := FALSE;
                                  ReQline.MODIFY;*/
                                UNTIL ReQline.NEXT = 0;
                            END;
                        END;


                    end;
                }
            }
        }
        area(reporting)
        {
            action("Inventory Movement Archive")
            {
                Caption = 'Inventory Movement Archive';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Line Archive";
                begin
                    /*
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
                    //TBL jose
                    ItemJnlLine.SETRANGE("Purchase Requisition No." ,"Purchase Requisition No."); //jose
                    
                    REPORT.RUNMODAL(REPORT::"Inventory Movement Archive",TRUE,TRUE,ItemJnlLine);
                    */

                end;
            }
        }
        area(navigation)
        {
            group(Requisition)
            {
                Caption = 'Requisition';
                Image = Versions;
                action("<Page Requisition Card>")
                {
                    Caption = 'Requisition Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Issued Internal Requisition";
                    // RunPageLink = "No." = FIELD("Purchase Requisition No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }

    var
        ReQline: Record "Item Line Archive";
        itemJnlLine: Record "Item Journal Line";
        lineNo: Integer;
        Sourcecodesetup: Record "Source Code Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        counter: Integer;
        StoreEmp: Record "Warehouse Employee";
        UserSetup: Record "User Setup";
        //NavigatorManagement: Codeunit "Navigator Management NVG";
        whseEmp: Record "Warehouse Employee";
        InventorySetup: Record "Inventory Setup";
}

