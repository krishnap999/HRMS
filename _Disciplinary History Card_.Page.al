page 70518 "Disciplinary History Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Disciplinary History";

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
                // Start Anmol 28 jan 25
                field("Disciplinary Charges File Name";Rec."Disciplinary Charges File Name")
                {
                    ApplicationArea = All;
                }
                // field("Upload Disciplinary ChargesDoc"; Rec."Upload Disciplinary ChargesDoc")
                // {
                //     ApplicationArea = All;
                // }
                // End Anmol
                field("Disciplinary CaseLetter No";Rec."Disciplinary CaseLetter No")
                {
                    ApplicationArea = All;
                }
                field("Disciplinary CaseDate";Rec."Disciplinary CaseDate")
                {
                    ApplicationArea = All;
                }
                field("Disciplinary CasesStatus";Rec."Disciplinary CaseStatus")
                {
                    ApplicationArea = All;
                }
                field("WhetherPlaced under suspension";Rec."WhetherPlaced under suspension")
                {
                    ApplicationArea = All;

                    trigger Onvalidate()var myInt: Integer;
                    begin
                        if rec."Whether reinstated" = true then Error('You Can not tick this boolean because Reinstated boolean is already true. If you want to tick this boolean then please untick Reinstated boolean.');
                    end;
                }
                field("Whether reinstated";Rec."Whether reinstated")
                {
                    ApplicationArea = All;

                    trigger onvalidate()var myInt: Integer;
                    begin
                        if rec."WhetherPlaced under suspension" then Error('You Can not tick this boolean because suspension boolean is already true. If you want to tick this boolean then please untick suspension boolean.');
                    end;
                }
                field(VigilanceCasePending;Rec.VigilanceCasePending)
                {
                    ApplicationArea = All;
                    Caption = 'Vigilance Case Pending';
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
