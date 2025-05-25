page 33065732 "Employee Transfer Joining card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Employee Transfer Joining card';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(HRMSID;HRMSID)
                {
                    ApplicationArea = All;
                    Caption = 'HRMS ID';

                    //TableRelation = Employee."No.";
                    trigger onValidate()var Employee: Record 5200;
                    TransferHistLLLrec: Record "Transfer Joining History";
                    begin
                    /*Employee.Reset();
                        Employee.SetRange("No.", HRMSID);
                        If Employee.FindFirst() then begin
                            Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            Designation := Employee.Designation;
                            //BKS_CodeCommented_08092022*/
                    /*if Employee.Status = Employee.Status::Inactive then begin
                            TransferHistLLLrec.Reset();
                            TransferHistLLLrec.SetRange("HRMS ID", HRMSID);
                            // TransferHistLLLrec.SetRange("Relieving Event", TransferHistLLLrec."Relieving Event"::"Promotion Transfer");
                            TransferHistLLLrec.SetRange(Status, TransferHistLLLrec.Status::Relieved);
                            if TransferHistLLLrec.FindFirst() then begin
                                FromStation := TransferHistLLLrec."From Station";
                                ToStation := TransferHistLLLrec."To Station";
                                LetterNo := TransferHistLLLrec."Letter No";
                                TransferOrderDate := TransferHistLLLrec."Transfer Date";
                                OrderIssueAuthVar := TransferHistLLLrec."Order Issuing Authority";
                                RelifeOrderDateVar := TransferHistLLLrec."Relief Order Date";
                                RelifeOrderNoVar := TransferHistLLLrec."Relief Order No.";
                                if TransferHistLLLrec."Relieving Event" = TransferHistLLLrec."Relieving Event"::"Promotion Transfer" then begin
                                    Todesignation := TransferHistLLLrec."To Designation";
                                    PromotionOredrDateVar := TransferHistLLLrec."Promotion order date";
                                    TodesignationBoolVar := true;

                                end;


                            end;

                        end;*/
                    //BKS_CodeCommented_08092022
                    //end;
                    end;
                }
                field(FromStation;FromStation)
                {
                    ApplicationArea = All;
                    Caption = 'From Station';
                    //Editable = false;    //BKS_CodeCommented_08092022
                    TableRelation = Company.Name;

                    trigger OnValidate()var TransferHistLLLrec: Record "Transfer Joining History";
                    begin
                        TransferHistLLLrec.ChangeCompany(FromStation);
                        TransferHistLLLrec.SetRange("HRMS ID", HRMSID);
                        TransferHistLLLrec.SetRange(Status, TransferHistLLLrec.Status::Relieved);
                        if TransferHistLLLrec.FindLast()then begin
                            Name:=TransferHistLLLrec.Name;
                            Designation:=TransferHistLLLrec.Designation;
                            ToStation:=TransferHistLLLrec."To Station";
                            LetterNo:=TransferHistLLLrec."Letter No";
                            TransferOrderDate:=TransferHistLLLrec."Transfer Date";
                            OrderIssueAuthVar:=TransferHistLLLrec."Order Issuing Authority";
                            RelifeOrderDateVar:=TransferHistLLLrec."Relief Order Date";
                            RelifeOrderNoVar:=TransferHistLLLrec."Relief Order No.";
                            if TransferHistLLLrec."Relieving Event" = TransferHistLLLrec."Relieving Event"::"Promotion Transfer" then begin
                                Todesignation:=TransferHistLLLrec."To Designation";
                                PromotionOredrDateVar:=TransferHistLLLrec."Promotion order date";
                                TodesignationBoolVar:=true;
                            end;
                        end
                        else
                            Error('In company %1 relieve record is not there for employee %2', FromStation, HRMSID);
                    end;
                }
                field("Employee Name";Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Designation;Designation)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ToStation;ToStation)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'To Station';
                //TableRelation = Institute."Institute Code";    //BKS_CodeCommented_08092022
                }
                field(TransferOrderDate;TransferOrderDate)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Transfer Order Date';
                }
                field(LetterNo;LetterNo)
                {
                    Editable = false;
                    ApplicationArea = All;
                    Caption = 'Letter No';
                }
                field(JoiningDate;JoiningDate)
                {
                    ApplicationArea = All;
                    Caption = 'Joining Date';
                }
                field(JoiningEvent;JoiningEvent)
                {
                    ApplicationArea = All;
                    Caption = 'Joining Event';
                }
                field("Order Issuing Authority";OrderIssueAuthVar)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Relief Order No.";RelifeOrderNoVar)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Relief Order Date";RelifeOrderDateVar)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Promotion To Designation";Todesignation)
                {
                    Editable = false;
                    Enabled = TodesignationBoolVar;
                    ApplicationArea = All;
                    Caption = 'Promotion To Designation';
                }
                field("Promotion  Order Date";PromotionOredrDateVar)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = TodesignationBoolVar;
                    Caption = 'Promotion Order Date';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Join")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()var EmployeeLocVar: Record 5200;
                EmployeeRec1: Record 5200;
                begin
                    EmployeeRec.ChangeCompany(FromStation);
                    if EmployeeRec.Get(HRMSID)then;
                    TransferHist1.ChangeCompany(FromStation);
                    TransferHist1.Reset();
                    TransferHist1.SetRange("HRMS ID", HRMSID);
                    TransferHist1.SetRange("Letter No", LetterNo);
                    TransferHist1.SetRange(Status, TransferHist1.Status::Relieved);
                    IF TransferHist1.FindFirst()then begin
                        if TransferHist1."Relieving Event" = TransferHist1."Relieving Event"::"Promotion Transfer" then begin
                            PromotedHist.ChangeCompany(FromStation);
                            PromotedHist.Reset();
                            PromotedHist.Init();
                            PromotedHist."HRMS ID":=HRMSID;
                            PromotedHist.Name:=Name;
                            PromotedHist."From Designation":=Designation;
                            PromotedHist."To Designation":=Todesignation;
                            PromotedHist."Promotion Order Date":=PromotionOredrDateVar;
                            PromotedHist."Letter NO":=LetterNo;
                            // EmployeeRec.ChangeCompany(FromStation);
                            // EmployeeLocVar.Get(HRMSID);
                            // EmployeeLocVar.Designation := Todesignation;
                            // EmployeeLocVar.Modify(true);
                            PromotedHist.Insert(true);
                        end;
                        if EmployeeRec."D.O.S" >= JoiningDate then begin
                            TransferHist.Init();
                            TransferHist."HRMS ID":=HRMSID;
                            TransferHist.Name:=Name;
                            TransferHist.Designation:=Designation;
                            TransferHist."From Station":=FromStation;
                            TransferHist."To Station":=ToStation;
                            TransferHist."Transfer Date":=TransferOrderDate;
                            TransferHist."Letter No":=LetterNo;
                            TransferHist."Joining Event":=JoiningEvent;
                            TransferHist."Joining Date":=JoiningDate;
                            TransferHist.Status:=TransferHist.Status::Joined;
                            TransferHist."Order Issuing Authority":=OrderIssueAuthVar;
                            TransferHist."Relief Order Date":=RelifeOrderDateVar;
                            TransferHist."Relief Order No.":=RelifeOrderNoVar;
                            TransferHist.Insert;
                            /*EmployeeRec.Reset();
                            EmployeeRec.SetRange("No.", HRMSID);
                            IF EmployeeRec.FindFirst() then begin
                                EmployeeRec.Status := "Employee Status"::Active;
                                EmployeeRec.Modify;
                            end;*/
                            EmployeeLocVar.ChangeCompany(FromStation);
                            IF EmployeeLocVar.Get(HRMSID)then;
                            EmployeeRec1.Init();
                            EmployeeRec1.Copy(EmployeeLocVar);
                            EmployeeRec1.Status:=EmployeeRec1.Status::Active;
                            EmployeeRec1."Current Station":=CompanyName; //SK_Sk
                            EmployeeRec1.Designation:=Todesignation;
                            EmployeeRec1.Insert();
                            Message('Joining of employee %1 done  successfully', HRMSID);
                        end
                        else
                            Error('User Can not joined. Because DOS crossed.The joining date greater than DOS.Please contact relieving institute.');
                        // end else
                        //Error('No relieved records there for this employee %1', HRMSID);
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()begin
        OrderIssueAuthVar:=OrderIssueAuthVar::" ";
    end;
    var HRMSID: Code[20];
    Name: Text[90];
    Designation: Code[20];
    FromStation: Text[50];
    ToStation: Text[50];
    TransferOrderDate: Date;
    LetterNo: Code[20];
    JoiningEvent: Enum "Joining Event";
    TransferHist: Record "Transfer Joining History";
    TransferHist1: Record "Transfer Joining History";
    JoiningDate: Date;
    EmployeeRec: Record 5200;
    PromotedHist: Record "Employee Promotion History";
    Todesignation: Code[20];
    TodesignationBoolVar: Boolean;
    PromotionOredrDateVar: Date;
    OrderIssueAuthVar: Option "DTE&T", "SDTE", " ";
    RelifeOrderNoVar: Code[30];
    RelifeOrderDateVar: Date;
    RelievingEvent: Text[100];
}
