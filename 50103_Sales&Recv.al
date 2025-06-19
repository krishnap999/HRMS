pageextension 50111 EmployeeCardExt extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Customer Nos.")
        {
            field("Sanctioned Post No."; Rec."Sanctioned Post No.")
            {
                ApplicationArea = All;

            }
        }
    }
}
