permissionset 2805 "Service Items - View"
{
    Access = Public;
    Assignable = false;
    Caption = 'Read service items';

    Permissions = tabledata Customer = R,
                  tabledata Item = R,
                  tabledata "Item Unit of Measure" = R,
                  tabledata "Item Variant" = R,
                  tabledata Resource = R,
                  tabledata "Resource Skill" = R,
                  tabledata "Service Comment Line" = RI,
                  tabledata "Service Contract Line" = R,
                  tabledata "Service Cr.Memo Line" = R,
                  tabledata "Service Invoice Line" = R,
                  tabledata "Service Item" = R,
                  tabledata "Service Item Component" = R,
                  tabledata "Service Item Group" = R,
                  tabledata "Service Item Line" = R,
                  tabledata "Service Item Log" = R,
                  tabledata "Service Ledger Entry" = R,
                  tabledata "Service Line" = R,
                  tabledata "Service Mgt. Setup" = R,
                  tabledata "Service Shipment Item Line" = R,
                  tabledata "Service Shipment Line" = R,
                  tabledata "Ship-to Address" = R,
                  tabledata "Troubleshooting Header" = R,
                  tabledata "Troubleshooting Line" = R,
                  tabledata "Troubleshooting Setup" = R,
                  tabledata Vendor = R,
                  tabledata "Warranty Ledger Entry" = R;
}
