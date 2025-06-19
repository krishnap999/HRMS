page 50107 "Sanctioned v/s Vacant List"
{
    PageType = List;
    CardPageId = "Sanctioned v/s Vacant";
    ApplicationArea = All;
    Editable = FALSE;
    Caption = 'Sactioned Post List';
    UsageCategory = Administration;
    SourceTable = "Sanctioned v/s Vacant";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Sanctioned Post No."; Rec."Sanctioned Post No.")
                {
                    ApplicationArea = all;
                }
                field("Department/Trade/Section"; Rec."Department/Trade/Section")
                {
                    ApplicationArea = ALL;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = ALL;
                }
                field("Approval No."; Rec."Approval No.")
                {
                }
                field("Sactioned Strength"; Rec."Sactioned Strength")
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field("Uploaded Document"; Rec."Uploaded Document")
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
                trigger OnAction()
                begin
                end;
            }
        }
    }
    var
        myInt: Integer;
}
