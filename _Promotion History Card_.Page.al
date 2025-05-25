page 33065740 "Promotion History Card"
{
    PageType = Card;
    // ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Employee Promotion History";
    //Editable = false;
    Caption = 'Employee promotion History card';

    layout
    {
        area(Content)
        {
            group(GroupName)
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
                field("From Designation";rec."From Designation")
                {
                    ApplicationArea = All;
                }
                field("To Designation";rec."To Designation")
                {
                    ApplicationArea = All;
                }
                field("Promotion Order Date";rec."Promotion Order Date")
                {
                    ApplicationArea = All;
                }
                field("Letter NO";rec."Letter NO")
                {
                    ApplicationArea = All;
                }
                field("Order Issuing Authority";rec."Order Issuing Authority")
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
        // action(ActionName)
        // {
        //     ApplicationArea = All;
        //     trigger OnAction()
        //     begin
        //     end;
        // }
        }
    }
    var myInt: Integer;
}
