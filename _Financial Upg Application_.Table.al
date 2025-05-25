table 33065968 "Financial Upg Application"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1;"HRMS ID";Code[20])
        {
            Caption = 'HRMS ID';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." where("SLCM Employee"=const(false));

            trigger OnValidate()var EmplRec: Record Employee;
            begin
                if EmplRec.Get("HRMS ID")then if EmplRec."Middle Name" <> '' then Name:=EmplRec."First Name" + ' ' + EmplRec."Middle Name" + ' ' + EmplRec."Last Name"
                    else
                        Name:=EmplRec."First Name" + ' ' + EmplRec."Last Name";
                Designation:=EmplRec.Designation;
            end;
        }
        field(2;Name;Text[90])
        {
            Caption = 'Employee Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3;Designation;Code[20])
        {
        }
        field(4;"Date of application upload";Date)
        {
            Caption = 'Date of application upload';
            DataClassification = ToBeClassified;
        }
        field(5;"Type";Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ", MACP, RACP;
        }
        field(6;"Application file";Blob)
        {
            Caption = 'Application file';
            DataClassification = ToBeClassified;
        }
        field(7;"Application file name";Text[100])
        {
            Caption = 'Application file Name';
            DataClassification = ToBeClassified;
        }
        field(8;"Current Station";Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Institute."Institute Code";
        }
        field(9;"Entry No.";Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(10;"Status";Option)
        {
            OptionMembers = Applied, Objected, Processed, Rejected;
        }
    }
    keys
    {
        key(pk;"Entry No.", "HRMS ID")
        {
            Clustered = true;
        }
    }
    var myInt: Integer;
    ArchiveFinUpgTab: record "Financial Upg App history";
    trigger OnInsert()var entrno: Integer;
    begin
        ArchiveFinUpgTab.Reset();
        if ArchiveFinUpgTab.FindLast()then entrno:=ArchiveFinUpgTab.Sl_no + 1
        else
            entrno:=1;
        ArchiveFinUpgTab.Reset();
        ArchiveFinUpgTab.Init();
        ArchiveFinUpgTab.TransferFields(Rec);
        ArchiveFinUpgTab.Sl_no:=entrno;
        ArchiveFinUpgTab.Insert(true);
    end;
    trigger OnModify()var entrno: Integer;
    begin
        ArchiveFinUpgTab.Reset();
        if ArchiveFinUpgTab.FindLast()then entrno:=ArchiveFinUpgTab.Sl_no + 1
        else
            entrno:=1;
        ArchiveFinUpgTab.Reset();
        ArchiveFinUpgTab.Init();
        ArchiveFinUpgTab.TransferFields(Rec);
        ArchiveFinUpgTab.Sl_no:=entrno;
        ArchiveFinUpgTab.Insert(true);
    end;
    trigger OnDelete()var entrno: Integer;
    begin
        ArchiveFinUpgTab.Reset();
        if ArchiveFinUpgTab.FindLast()then entrno:=ArchiveFinUpgTab.Sl_no + 1
        else
            entrno:=1;
        ArchiveFinUpgTab.Reset();
        ArchiveFinUpgTab.Init();
        ArchiveFinUpgTab.TransferFields(Rec);
        ArchiveFinUpgTab.Sl_no:=entrno;
        ArchiveFinUpgTab.Insert(true);
    end;
    trigger OnRename()var entrno: Integer;
    begin
        ArchiveFinUpgTab.Reset();
        if ArchiveFinUpgTab.FindLast()then entrno:=ArchiveFinUpgTab.Sl_no + 1
        else
            entrno:=1;
        ArchiveFinUpgTab.Reset();
        ArchiveFinUpgTab.Init();
        ArchiveFinUpgTab.TransferFields(Rec);
        ArchiveFinUpgTab.Sl_no:=entrno;
        ArchiveFinUpgTab.Insert(true);
    end;
}
