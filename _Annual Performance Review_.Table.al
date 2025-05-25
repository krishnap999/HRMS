table 33065868 "Annual Performance Review"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1;"Entry No";Integer)
        {
            AutoIncrement = true;
        }
        field(2;"HRMS ID";Code[20])
        {
        }
        field(3;Name;Text[90])
        {
        }
        field(4;"Designation";Code[20])
        {
        }
        field(5;"Department";Text[30])
        {
        }
        field(6;"Academic Year";Code[20])
        {
        }
        field(7;"Performance Rating";Text[3])
        {
        }
        field(8;"Created By";Code[50])
        {
        }
        field(9;"Created Date Time";DateTime)
        {
        }
        field(10;"Modified By";Code[50])
        {
        }
        field(11;"Modified Date Time";DateTime)
        {
        }
    }
    keys
    {
        key(PK;"Entry No")
        {
            Clustered = true;
        }
    }
    var ArchannuperRec: Record "Archive Annual Perfor. Review";
    trigger OnInsert()begin
        "Created By":=UserId;
        "Created Date Time":=CurrentDateTime;
        ArchannuperRec.Reset();
        ArchannuperRec.Init();
        ArchannuperRec.TransferFields(Rec);
        ArchannuperRec.Insert(true);
    end;
    trigger OnModify()begin
        "Modified By":=UserId;
        "Modified Date Time":=CurrentDateTime;
        ArchannuperRec.Reset();
        ArchannuperRec.Init();
        ArchannuperRec.TransferFields(Rec);
        ArchannuperRec.Insert(true);
    end;
    trigger OnDelete()begin
        ArchannuperRec.Reset();
        ArchannuperRec.Init();
        ArchannuperRec.TransferFields(Rec);
        ArchannuperRec.Insert(true);
    end;
    trigger OnRename()begin
        ArchannuperRec.Reset();
        ArchannuperRec.Init();
        ArchannuperRec.TransferFields(Rec);
        ArchannuperRec.Insert(true);
    end;
}
