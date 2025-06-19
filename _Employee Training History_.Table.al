table 70520 "Employee Training History"
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
        field(5;"Type Of Training";Enum "Type Of Training")
        {
        }
        field(6;"Course Name";Text[30])
        {
        }
        field(7;"Start Date";Date)
        {
        }
        field(8;"EndDate";Date)
        {
        }
        field(9;"Duration Of Training";Integer)
        {
        }
        field(10;"Conducted By";Text[30])
        {
        }
        field(11;"Training Location";Text[30])
        {
        }
        field(12;"Created By";Code[50])
        {
        }
        field(13;"Created Date Time";DateTime)
        {
        }
        field(14;"Modified By";Code[50])
        {
        }
        field(15;"Modified Date Time";DateTime)
        {
        }
        field(16;"Certificate FileName";Text[100])
        {
        }
        field(17;"Certificate";Blob)
        {
        }
        field(18;"Spcified Type of training";Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK;"Entry No")
        {
            Clustered = true;
        }
    }
    var ArchiveEmpTrainingRec: Record "Archive Employee Training Hist";
    trigger OnInsert()begin
        "Created By":=UserId;
        "Created Date Time":=CurrentDateTime;
        ArchiveEmpTrainingRec.Reset();
        ArchiveEmpTrainingRec.Init();
        ArchiveEmpTrainingRec.TransferFields(Rec);
        ArchiveEmpTrainingRec.Insert(true);
    end;
    trigger OnModify()begin
        "Modified By":=UserId;
        "Modified Date Time":=CurrentDateTime;
        ArchiveEmpTrainingRec.Reset();
        ArchiveEmpTrainingRec.Init();
        ArchiveEmpTrainingRec.TransferFields(Rec);
        ArchiveEmpTrainingRec.Insert(true);
    end;
    trigger OnDelete()begin
        ArchiveEmpTrainingRec.Reset();
        ArchiveEmpTrainingRec.Init();
        ArchiveEmpTrainingRec.TransferFields(Rec);
        ArchiveEmpTrainingRec.Insert(true);
    end;
    trigger OnRename()begin
        ArchiveEmpTrainingRec.Reset();
        ArchiveEmpTrainingRec.Init();
        ArchiveEmpTrainingRec.TransferFields(Rec);
        ArchiveEmpTrainingRec.Insert(true);
    end;
}
