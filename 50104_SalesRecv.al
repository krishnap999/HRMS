tableextension 50110 SalesREcvExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Sanctioned Post No."; Code[20])
        {
            Caption = 'Sanctioned Post No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";

        }
    }
}
