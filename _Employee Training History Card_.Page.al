page 70529 "Employee Training History Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Training History";

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
                field("Type Of Training";Rec."Type Of Training")
                {
                    ApplicationArea = All;
                }
                field("Traing Course Title";rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field("Training Starting Date";Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Training Ending Date";Rec.EndDate)
                {
                    ApplicationArea = All;
                }
                field("Duration Of Training";Rec."Duration Of Training")
                {
                    ApplicationArea = All;
                }
                field("Conducted By";Rec."Conducted By")
                {
                    ApplicationArea = All;
                }
                field("Training Location";Rec."Training Location")
                {
                    ApplicationArea = All;
                }
                field("Spcified Type of training";Rec."Spcified Type of training")
                {
                    ApplicationArea = All;
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
