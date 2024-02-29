table 50013 "Item Line Archive"
{

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(5; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(6; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Source Type" = CONST(Item)) Item;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(10; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Inventory Posting Group";
        }
        field(11; "Source Posting Group"; Code[10])
        {
            Caption = 'Source Posting Group';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = IF ("Source Type" = CONST(Customer)) "Customer Posting Group"
            ELSE
            IF ("Source Type" = CONST(Vendor)) "Vendor Posting Group"
            ELSE
            IF ("Source Type" = CONST(Item)) "Inventory Posting Group";
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                CallWhseCheck: Boolean;
            begin
            end;
        }
        field(15; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(16; "Unit Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Amount';
            DataClassification = ToBeClassified;
        }
        field(17; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            DataClassification = ToBeClassified;
        }
        field(18; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(22; "Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Discount Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(26; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Source Code";
        }
        field(29; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemTrackingLines: Page "Item Tracking Lines";
            begin
            end;
        }
        field(32; "Item Shpt. Entry No."; Integer)
        {
            Caption = 'Item Shpt. Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(35; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(37; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(39; "Source Type"; Option)
        {
            Caption = 'Source Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(41; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(42; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        field(43; "Recurring Method"; Option)
        {
            // // BlankZero = true;
            Caption = 'Recurring Method';
            DataClassification = ToBeClassified;
            OptionCaption = ',Fixed,Variable';
            OptionMembers = ,"Fixed",Variable;
        }
        field(44; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(45; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
            DataClassification = ToBeClassified;
        }
        field(46; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Type";
        }
        field(48; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            DataClassification = ToBeClassified;
            TableRelation = "Transport Method";
        }
        field(49; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(50; "New Location Code"; Code[10])
        {
            Caption = 'New Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(51; "New Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1,New ';
            Caption = 'New Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(52; "New Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2,New ';
            Caption = 'New Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(53; "Qty. (Calculated)"; Decimal)
        {
            Caption = 'Qty. (Calculated)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(54; "Qty. (Phys. Inventory)"; Decimal)
        {
            Caption = 'Qty. (Phys. Inventory)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(55; "Last Item Ledger Entry No."; Integer)
        {
            Caption = 'Last Item Ledger Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Item Ledger Entry";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(56; "Phys. Inventory"; Boolean)
        {
            Caption = 'Phys. Inventory';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(57; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
        }
        field(58; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group";
        }
        field(59; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            DataClassification = ToBeClassified;
            TableRelation = "Entry/Exit Point";
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(62; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(63; "Area"; Code[10])
        {
            Caption = 'Area';
            DataClassification = ToBeClassified;
            TableRelation = Area;
        }
        field(64; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            DataClassification = ToBeClassified;
            TableRelation = "Transaction Specification";
        }
        field(65; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(68; "Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Journal Template Name"),
                                                                  "Source Ref. No." = FIELD("Line No."),
                                                                  "Source Type" = CONST(83),
                                                                  "Source Subtype" = FIELD("Entry Type"),
                                                                  "Source Batch Name" = FIELD("Journal Batch Name"),
                                                                  "Source Prod. Order Line" = CONST(0),
                                                                  "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Unit Cost (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Cost (ACY)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(73; "Source Currency Code"; Code[10])
        {
            Caption = 'Source Currency Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Currency;
        }
        field(79; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo,Posted Assembly';
            OptionMembers = " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly";
        }
        field(80; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = ToBeClassified;
        }
        field(81; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Order Type"; Option)
        {
            Caption = 'Order Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Production,Transfer,Service,Assembly';
            OptionMembers = " ",Production,Transfer,Service,Assembly;
        }
        field(91; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Order Type" = CONST(Production)) "Production Order"."No." WHERE(Status = CONST(Released));

            trigger OnValidate()
            var
                AssemblyHeader: Record "Assembly Header";
            begin
            end;
        }
        field(92; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Order Type" = CONST(Production)) "Prod. Order Line"."Line No." WHERE(Status = CONST(Released),
                                                                                                     "Prod. Order No." = FIELD("Order No."));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(481; "New Dimension Set ID"; Integer)
        {
            Caption = 'New Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(904; "Assemble to Order"; Boolean)
        {
            Caption = 'Assemble to Order';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(1000; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            DataClassification = ToBeClassified;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            DataClassification = ToBeClassified;
        }
        field(1002; "Job Purchase"; Boolean)
        {
            Caption = 'Job Purchase';
            DataClassification = ToBeClassified;
        }
        field(1030; "Job Contract Entry No."; Integer)
        {
            Caption = 'Job Contract Entry No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Entry Type" = FILTER(Purchase | "Positive Adjmt." | Output),
                                Quantity = FILTER(>= 0)) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                      "Item Filter" = FIELD("Item No."),
                                                                      "Variant Filter" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER(Purchase | "Positive Adjmt." | Output),
                                                                               Quantity = FILTER(< 0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                    "Item No." = FIELD("Item No."),
                                                                                                                                    "Variant Code" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER(Sale | "Negative Adjmt." | Transfer | Consumption),
                                                                                                                                             Quantity = FILTER(> 0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                                                                                  "Item No." = FIELD("Item No."),
                                                                                                                                                                                                  "Variant Code" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER(Sale | "Negative Adjmt." | Transfer | Consumption),
                                                                                                                                                                                                           Quantity = FILTER(<= 0)) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                                                                                                                                 "Item Filter" = FIELD("Item No."),
                                                                                                                                                                                                                                                 "Variant Filter" = FIELD("Variant Code"));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5406; "New Bin Code"; Code[20])
        {
            Caption = 'New Bin Code';
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("New Location Code"),
                                            "Item Filter" = FIELD("Item No."),
                                            "Variant Filter" = FIELD("Variant Code"));

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
            end;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5408; "Derived from Blanket Order"; Boolean)
        {
            Caption = 'Derived from Blanket Order';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5413; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5415; "Invoiced Qty. (Base)"; Decimal)
        {
            Caption = 'Invoiced Qty. (Base)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5468; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("Journal Template Name"),
                                                                           "Source Ref. No." = FIELD("Line No."),
                                                                           "Source Type" = CONST(83),
                                                                           "Source Subtype" = FIELD("Entry Type"),
                                                                           "Source Batch Name" = FIELD("Journal Batch Name"),
                                                                           "Source Prod. Order Line" = CONST(0),
                                                                           "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5560; Level; Integer)
        {
            Caption = 'Level';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5561; "Flushing Method"; Option)
        {
            Caption = 'Flushing Method';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Manual,Forward,Backward,Pick + Forward,Pick + Backward';
            OptionMembers = Manual,Forward,Backward,"Pick + Forward","Pick + Backward";
        }
        field(5562; "Changed by User"; Boolean)
        {
            Caption = 'Changed by User';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5700; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = ToBeClassified;
        }
        field(5701; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(5702; "Originally Ordered Var. Code"; Code[10])
        {
            Caption = 'Originally Ordered Var. Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Originally Ordered No."));
        }
        field(5703; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
            DataClassification = ToBeClassified;
        }
        field(5704; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(5705; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            DataClassification = ToBeClassified;
        }
        field(5706; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            DataClassification = ToBeClassified;
            TableRelation = Purchasing;
        }
        field(5707; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            DataClassification = ToBeClassified;
            // TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(5791; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';
            DataClassification = ToBeClassified;
        }
        field(5793; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = ToBeClassified;
        }
        field(5800; "Value Entry Type"; Option)
        {
            Caption = 'Value Entry Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance';
            OptionMembers = "Direct Cost",Revaluation,Rounding,"Indirect Cost",Variance;
        }
        field(5801; "Item Charge No."; Code[20])
        {
            Caption = 'Item Charge No.';
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge";
        }
        field(5802; "Inventory Value (Calculated)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inventory Value (Calculated)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5803; "Inventory Value (Revalued)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inventory Value (Revalued)';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(5804; "Variance Type"; Option)
        {
            Caption = 'Variance Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Purchase,Material,Capacity,Capacity Overhead,Manufacturing Overhead';
            OptionMembers = " ",Purchase,Material,Capacity,"Capacity Overhead","Manufacturing Overhead";
        }
        field(5805; "Inventory Value Per"; Option)
        {
            Caption = 'Inventory Value Per';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Item,Location,Variant,Location and Variant';
            OptionMembers = " ",Item,Location,Variant,"Location and Variant";
        }
        field(5806; "Partial Revaluation"; Boolean)
        {
            Caption = 'Partial Revaluation';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5807; "Applies-from Entry"; Integer)
        {
            Caption = 'Applies-from Entry';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemTrackingLines: Page "Item Tracking Lines";
            begin
            end;
        }
        field(5808; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(5809; "Unit Cost (Calculated)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (Calculated)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5810; "Unit Cost (Revalued)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (Revalued)';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(5811; "Applied Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Applied Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5812; "Update Standard Cost"; Boolean)
        {
            Caption = 'Update Standard Cost';
            DataClassification = ToBeClassified;
        }
        field(5813; "Amount (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (ACY)';
            DataClassification = ToBeClassified;
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = ToBeClassified;
        }
        field(5818; Adjustment; Boolean)
        {
            Caption = 'Adjustment';
            DataClassification = ToBeClassified;
        }
        field(5819; "Applies-to Value Entry"; Integer)
        {
            Caption = 'Applies-to Value Entry';
            DataClassification = ToBeClassified;
        }
        field(5820; "Invoice-to Source No."; Code[20])
        {
            Caption = 'Invoice-to Source No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor;
        }
        field(5830; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Work Center,Machine Center, ,Resource';
            OptionMembers = "Work Center","Machine Center"," ",Resource;
        }
        field(5831; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST("Machine Center")) "Machine Center"
            ELSE
            IF (Type = CONST("Work Center")) "Work Center"
            ELSE
            IF (Type = CONST(Resource)) Resource;

            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
            end;
        }
        field(5838; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Order Type" = CONST(Production)) "Prod. Order Routing Line"."Operation No." WHERE(Status = CONST(Released),
                                                                                                                  "Prod. Order No." = FIELD("Order No."),
                                                                                                                  "Routing No." = FIELD("Routing No."),
                                                                                                                  "Routing Reference No." = FIELD("Routing Reference No."));
        }
        field(5839; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Work Center";
        }
        field(5841; "Setup Time"; Decimal)
        {
            Caption = 'Setup Time';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5842; "Run Time"; Decimal)
        {
            Caption = 'Run Time';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5843; "Stop Time"; Decimal)
        {
            Caption = 'Stop Time';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5846; "Output Quantity"; Decimal)
        {
            Caption = 'Output Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5847; "Scrap Quantity"; Decimal)
        {
            Caption = 'Scrap Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5849; "Concurrent Capacity"; Decimal)
        {
            Caption = 'Concurrent Capacity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                TotalTime: Integer;
            begin
            end;
        }
        field(5851; "Setup Time (Base)"; Decimal)
        {
            Caption = 'Setup Time (Base)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5852; "Run Time (Base)"; Decimal)
        {
            Caption = 'Run Time (Base)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5853; "Stop Time (Base)"; Decimal)
        {
            Caption = 'Stop Time (Base)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5856; "Output Quantity (Base)"; Decimal)
        {
            Caption = 'Output Quantity (Base)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5857; "Scrap Quantity (Base)"; Decimal)
        {
            Caption = 'Scrap Quantity (Base)';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5858; "Cap. Unit of Measure Code"; Code[10])
        {
            Caption = 'Cap. Unit of Measure Code';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(Resource)) "Resource Unit of Measure".Code WHERE("Resource No." = FIELD("No."))
            ELSE
            "Capacity Unit of Measure";
        }
        field(5859; "Qty. per Cap. Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Cap. Unit of Measure';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5873; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            DataClassification = ToBeClassified;
        }
        field(5874; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            DataClassification = ToBeClassified;
        }
        field(5882; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Routing Header";
        }
        field(5883; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
            DataClassification = ToBeClassified;
        }
        field(5884; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Order Type" = CONST(Production)) "Prod. Order Component"."Line No." WHERE(Status = CONST(Released),
                                                                                                          "Prod. Order No." = FIELD("Order No."),
                                                                                                          "Prod. Order Line No." = FIELD("Order Line No."));
        }
        field(5885; Finished; Boolean)
        {
            Caption = 'Finished';
            DataClassification = ToBeClassified;
        }
        field(5887; "Unit Cost Calculation"; Option)
        {
            Caption = 'Unit Cost Calculation';
            DataClassification = ToBeClassified;
            OptionCaption = 'Time,Units';
            OptionMembers = Time,Units;
        }
        field(5888; Subcontracting; Boolean)
        {
            Caption = 'Subcontracting';
            DataClassification = ToBeClassified;
        }
        field(5895; "Stop Code"; Code[10])
        {
            Caption = 'Stop Code';
            DataClassification = ToBeClassified;
            TableRelation = Stop;
        }
        field(5896; "Scrap Code"; Code[10])
        {
            Caption = 'Scrap Code';
            DataClassification = ToBeClassified;
            TableRelation = Scrap;
        }
        field(5898; "Work Center Group Code"; Code[10])
        {
            Caption = 'Work Center Group Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Work Center Group";
        }
        field(5899; "Work Shift Code"; Code[10])
        {
            Caption = 'Work Shift Code';
            DataClassification = ToBeClassified;
            TableRelation = "Work Shift";
        }
        field(6500; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6502; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6503; "New Serial No."; Code[20])
        {
            Caption = 'New Serial No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6504; "New Lot No."; Code[20])
        {
            Caption = 'New Lot No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6505; "New Item Expiration Date"; Date)
        {
            Caption = 'New Item Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(6506; "Item Expiration Date"; Date)
        {
            Caption = 'Item Expiration Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6600; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason";
        }
        field(7315; "Warehouse Adjustment"; Boolean)
        {
            Caption = 'Warehouse Adjustment';
            DataClassification = ToBeClassified;
        }
        field(7380; "Phys Invt Counting Period Code"; Code[10])
        {
            Caption = 'Phys Invt Counting Period Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Phys. Invt. Counting Period";
        }
        field(7381; "Phys Invt Counting Period Type"; Option)
        {
            Caption = 'Phys Invt Counting Period Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Item,SKU';
            OptionMembers = " ",Item,SKU;
        }
        field(50001; "Qty Issued"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Qty Remaining"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Vendor Item No."; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Purchaser Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                //GR

                if xRec."Qty Issued" <> "Qty Issued" then begin
                    //code here
                    whseEmp.Reset;
                    whseEmp.SetRange(whseEmp."User ID", UpperCase(UserId));
                    whseEmp.SetRange(whseEmp."Location Code", "Location Code");
                    // whseEmp.SetRange(whseEmp.Supervisor, true);
                    if whseEmp.Find('-') then begin
                        exit;
                    end
                    else begin
                        Error('You are not allowed to modify this field! Only warehouse supervisors can modify the purchaser code');
                    end;
                end;
            end;
        }
        field(50005; "Fully Issued"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Issue to Fund"; Code[10])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Fund NVG";

            trigger OnValidate()
            begin
                IF ("Issue to Fund" <> '') AND ("Entry Type" <> "Entry Type"::"Negative Adjmt.") THEN
                    ERROR('Issue to Fund can only be selected when Entry Type is Negative Adjustment');


            end;
        }
        field(50012; "Quantity Available"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50013; "Requisition Qty Requested"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37001000; "Purchase Requisition No."; Code[20])
        {
            Caption = 'Purchase Requisition No.';
            DataClassification = ToBeClassified;
        }
        field(37001001; "Purchase Requisition Line No."; Integer)
        {
            Caption = 'Purchase Requisition Line No.';
            DataClassification = ToBeClassified;
        }
        field(37001005; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'New,Approval Pending,Transfer Budget Pending,Approved,Disapproved';
            OptionMembers = New,"Approval Pending","Transfer Budget Pending",Approved,Disapproved;
        }
        field(37001006; "Document Post Status"; Boolean)
        {
            Caption = 'Document Post Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37001015; Comment; Boolean)
        {
            /*  CalcFormula = Exist("Journal Comment Line NVG"
              WHERE("Table ID" = CONST(83),
                                                               "Journal Template Name" = FIELD("Journal Template Name"),
                                                               "Journal Batch Name" = FIELD("Journal Batch Name"),
                                                               "Document No." = FIELD("Document No.")));
             Caption = 'Comment';
             Editable = false;
             FieldClass = FlowField; */
        }
        field(37001043; "Allocation No."; Code[10])
        {
            Caption = 'Allocation No.';
            DataClassification = ToBeClassified;
            /* TableRelation = "Allocation Header NVG"."No." WHERE("Allocation Type" = CONST(Line),
                                                             "Calculation Type" = FILTER(<> "Calculated Line")); */
        }
        field(37001050; "Fund No."; Code[10])
        {
            Caption = 'Fund No.';
            DataClassification = ToBeClassified;
            //TableRelation = "Fund NVG";
        }
        field(37001051; "Ctl. Fund No."; Code[10])
        {
            Caption = 'Ctl. Fund No.';
            DataClassification = ToBeClassified;
            //  TableRelation = "Fund NVG";
        }
        field(37001052; "Fund Class Code"; Code[10])
        {
            Caption = 'Fund Class Code';
            DataClassification = ToBeClassified;
            // TableRelation = "Fund Class NVG";
        }
        field(37001053; "Shortcut Dimension 3 Code"; Code[10])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(37001054; "Shortcut Dimension 4 Code"; Code[10])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(37001055; "Shortcut Dimension 5 Code"; Code[10])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(37001056; "Shortcut Dimension 6 Code"; Code[10])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(37001057; "Shortcut Dimension 7 Code"; Code[10])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(37001058; "Shortcut Dimension 8 Code"; Code[10])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(37001059; "Dimension Speedkey Code"; Code[10])
        {
            Caption = 'Dimension Speedkey Code';
            DataClassification = ToBeClassified;
            // TableRelation = "Dimension Speedkey NVG";
        }
        field(37001060; "New Shortcut Dimension 3 Code"; Code[10])
        {
            CaptionClass = '1,2,3,New ';
            Caption = 'New Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(37001061; "New Shortcut Dimension 4 Code"; Code[10])
        {
            CaptionClass = '1,2,4,New ';
            Caption = 'New Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(37001062; "New Shortcut Dimension 5 Code"; Code[10])
        {
            CaptionClass = '1,2,5,New ';
            Caption = 'New Shortcut Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(37001063; "New Shortcut Dimension 6 Code"; Code[10])
        {
            CaptionClass = '1,2,6,New ';
            Caption = 'New Shortcut Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(37001064; "New Shortcut Dimension 7 Code"; Code[10])
        {
            CaptionClass = '1,2,7,New ';
            Caption = 'New Shortcut Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(37001065; "New Shortcut Dimension 8 Code"; Code[10])
        {
            CaptionClass = '1,2,8,New ';
            Caption = 'New Shortcut Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(37001066; "New Fund No."; Code[10])
        {
            Caption = 'New Fund No.';
            DataClassification = ToBeClassified;
            //     TableRelation = "Fund NVG";
        }
        field(37001099; "Internal Control No."; Code[50])
        {
            Caption = 'Internal Control No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37001131; "Owner ID"; Code[50])
        {
            Caption = 'Owner ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(99000755; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(99000756; "Single-Level Material Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Material Cost';
            DataClassification = ToBeClassified;
        }
        field(99000757; "Single-Level Capacity Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Capacity Cost';
            DataClassification = ToBeClassified;
        }
        field(99000758; "Single-Level Subcontrd. Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Subcontrd. Cost';
            DataClassification = ToBeClassified;
        }
        field(99000759; "Single-Level Cap. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Cap. Ovhd Cost';
            DataClassification = ToBeClassified;
        }
        field(99000760; "Single-Level Mfg. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Mfg. Ovhd Cost';
            DataClassification = ToBeClassified;
        }
        field(99000761; "Rolled-up Material Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Material Cost';
            DataClassification = ToBeClassified;
        }
        field(99000762; "Rolled-up Capacity Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Capacity Cost';
            DataClassification = ToBeClassified;
        }
        field(99000763; "Rolled-up Subcontracted Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Subcontracted Cost';
            DataClassification = ToBeClassified;
        }
        field(99000764; "Rolled-up Mfg. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Mfg. Ovhd Cost';
            DataClassification = ToBeClassified;
        }
        field(99000765; "Rolled-up Cap. Overhead Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Cap. Overhead Cost';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry Type", "Item No.", "Variant Code", "Location Code", "Bin Code", "Posting Date")
        {
        }
        key(Key3; "Entry Type", "Item No.", "Variant Code", "New Location Code", "New Bin Code", "Posting Date")
        {
        }
        key(Key4; "Item No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        whseEmp: Record "Warehouse Employee";
        loc: Record Location;
}

