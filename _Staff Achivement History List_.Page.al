page 33065743 "Staff Achivement History List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staff Achivement History";
    Caption = 'Employee Profile & Award Achievement History List';
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No";rec."Entry No")
                { //ApplicationArea = All; 
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
                field("Base Qualification";rec."Base Qualification")
                {
                    ApplicationArea = All;
                }
                field("Inservice Qualification. Upgradation";rec."Inservice Qua. Upgradation")
                {
                    ApplicationArea = All;
                }
                field("In-service Qualification Details";rec."Inservise Qualification Detail")
                {
                    ApplicationArea = All;
                }
                field(Award;rec.Award)
                {
                    ApplicationArea = All;
                }
                field("Award Details";rec."Award Details")
                {
                    ApplicationArea = All;
                }
                field("Achivement Remarks";rec."Achivement Remarks")
                {
                    ApplicationArea = All;
                }
                field("Academic Year";rec."Academic Year")
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
