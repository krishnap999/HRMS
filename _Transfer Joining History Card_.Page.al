page 70551 "Transfer Joining History Card"
{
    PageType = Card;
    // ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Transfer Joining History";

    //Editable = False;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Entry No";Rec."Entry No")
                {
                }
                field("HRMS ID";Rec."HRMS ID")
                {
                }
                field("Employee Name";Rec.Name)
                {
                }
                field(Designation;Rec.Designation)
                {
                }
                field("From Station";Rec."From Station")
                {
                }
                field("To Station";Rec."To Station")
                {
                }
                field("Transfer Order Date";Rec."Transfer Date")
                {
                }
                field("Letter No";Rec."Letter No")
                {
                }
                field("Relieving Event";Rec."Relieving Event")
                {
                }
                field("Joining Event";Rec."Joining Event")
                {
                }
                field("Joining Date";Rec."Joining Date")
                {
                }
                field(Status;Rec.Status)
                {
                }
                field("Relief Order No.";Rec."Relief Order No.")
                {
                }
                field("Relief Order Date";Rec."Relief Order Date")
                {
                }
                field("To Designation";Rec."To Designation")
                {
                }
                field("Order Issuing Authority";Rec."Order Issuing Authority")
                {
                }
                field("Promotion order date";Rec."Promotion order date")
                {
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
