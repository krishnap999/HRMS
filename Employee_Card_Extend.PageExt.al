pageextension 70500 Employee_Card_Extend extends "Employee Card"
{
    layout
    {
        addlast(General)
        {
            field("SLCM Employee";Rec."SLCM Employee")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnInsertRecord(Bool: Boolean): Boolean begin
        Rec."SLCM Employee":=true;
    end;
// trigger OnOpenPage()
// begin
//     FilterGroup(0);
//     SetRange("SLCM Employee", false);
//     FilterGroup(2);
// end;
}
