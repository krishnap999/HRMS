page 33065745 "Disciplinary History List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Disciplinary History";
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    // CardPageId = "Disciplinary History Card";
    Caption = 'Employee Disciplinary Case History List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No";rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("HRMS ID";rec."HRMS ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name";rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Designation;rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Disciplinary Charges";rec."Disciplinary Charges")
                {
                    ApplicationArea = All;
                }
                field("Disciplinary CaseLetter No";rec."Disciplinary CaseLetter No")
                {
                    ApplicationArea = All;
                }
                field("Disciplinary CaseDate";rec."Disciplinary CaseDate")
                {
                    ApplicationArea = All;
                }
                field("Disciplinary CasesStatus";rec."Disciplinary CaseStatus")
                {
                    ApplicationArea = All;
                }
                field("WhetherPlaced under suspension";rec."WhetherPlaced under suspension")
                {
                    ApplicationArea = All;
                }
                field("Whether reinstated";rec."Whether reinstated")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                // ApplicationArea = All;
                trigger OnAction();
                begin
                end;
            }
        }
    }
}
