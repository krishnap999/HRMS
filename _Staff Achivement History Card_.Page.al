page 70546 "Staff Achivement History Card"
{
    PageType = Card;
    // ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Staff Achivement History";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Entry No";Rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("HRMS ID";Rec."HRMS ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name";Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Designation;Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Base Qualification";Rec."Base Qualification")
                {
                    ApplicationArea = All;
                }
                field("Inservice Qualification. Upgradation";Rec."Inservice Qua. Upgradation")
                {
                    ApplicationArea = All;
                }
                field(Award;Rec.Award)
                {
                    ApplicationArea = All;
                }
                field("Achivement Remarks";Rec."Achivement Remarks")
                {
                    ApplicationArea = All;
                }
                field("Academic Year";Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Award Details";Rec."Award Details")
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
                ApplicationArea = All;

                trigger OnAction()begin
                end;
            }
        }
    }
    var myInt: Integer;
}
