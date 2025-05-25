table 33065973 "Financial Upg App history"
{
    DataClassification = ToBeClassified;
    Caption = 'Archieved Financial Upg Appplication';

    fields
    {
        field(1;"HRMS ID";Code[20])
        {
            Caption = 'HRMS ID';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

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
        field(11;"Sl_no";Integer)
        {
            DataClassification = ToBeClassified;
        // AutoIncrement = true;
        }
        field(12;"User Id";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Modified Date Time";DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(pk;Sl_no)
        {
            Clustered = true;
        }
    }
    var myInt: Integer;
    trigger OnInsert()begin
        "Modified Date Time":=CurrentDateTime;
        "User Id":=UserId;
    end;
    trigger OnModify()begin
    end;
    trigger OnDelete()begin
    end;
    trigger OnRename()begin
    end;
}
