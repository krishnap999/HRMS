page 50100 "Financial Upg App History"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Financial Upg App history";
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("HRMS ID";Rec."HRMS ID")
                {
                    ApplicationArea = all;
                }
                field(Name;Rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Designation;Rec.Designation)
                {
                    ApplicationArea = all;
                }
                field("Date of application upload";Rec."Date of application upload")
                {
                    ApplicationArea = all;
                }
                field(Type;Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Application file";Rec."Application file")
                {
                    ApplicationArea = all;
                }
                field("Application file name";Rec."Application file name")
                {
                    ApplicationArea = all;
                }
                field("Current Station";Rec."Current Station")
                {
                    ApplicationArea = all;
                }
                field("Entry No.";Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Sl_no;Rec.Sl_no)
                {
                    ApplicationArea = all;
                }
                field("User Id";Rec."User Id")
                {
                    Caption = 'Modified By';
                    ApplicationArea = all;
                }
                field("Modified Date Time";Rec."Modified Date Time")
                {
                    Caption = 'Modified On';
                    ApplicationArea = all;
                }
                field("Effective Date Of MACP";Rec."Effective Date Of MACP")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                trigger OnAction()begin
                end;
            }
        }
    }
    var myInt: Integer;
}
