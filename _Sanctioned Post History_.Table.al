table 50104 "Sanctioned Post History"
{
    Caption = 'Sanctioned Post History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            //  AutoIncrement = true;
        }
        field(2; "Sanctioned Post No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Old Sanctioned Strength"; Integer)
        {
            Caption = 'Old Sanctioned Strength';
        }
        field(4; "New Sanctioned Strength"; Integer)
        {
            Caption = 'Modified Sanctioned Strength';
        }
        field(5; "Designation"; Text[250])
        {
        }
        field(6; "Department/Trade/Section"; Text[250])
        {
        }
        field(7; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
        }
        field(8; "Modified On"; DateTime)
        {
            Caption = 'Modified On';
        }
        field(10; "Approval No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Approval No.';
        }
        field(11; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(12; ApplicantNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; ApplicantNo)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        SanctionedPostHistory: Record "Sanctioned Post History";
    begin
        SanctionedPostHistory.Reset();
        if SanctionedPostHistory.FindLast() then
            Rec.ApplicantNo := SanctionedPostHistory.ApplicantNo + 1
        else
            Rec.ApplicantNo := 1;
    end;
}
