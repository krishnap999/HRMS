page 70539 "Financial Upg Application"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Financial Upg Application";
    Caption = 'Financial Upgradation Application Form';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("HRMS ID";HRMSID)
                {
                    ApplicationArea = All;
                    TableRelation = Employee."No." where("SLCM Employee"=const(false));

                    trigger OnValidate()var EmpVar: Record Employee;
                    FinUpgr: Record "Financial Upg Application";
                    begin
                        if EmpVar.Get(HRMSID)then begin
                            EmpNameVar:=EmpVar."First Name";
                            DesigngVar:=EmpVar.Designation;
                            DatAppUpdate:=Today;
                            FinUpgr.Reset();
                            FinUpgr.SetRange("HRMS ID", HRMSID);
                            if FinUpgr.FindLast()then typevar:=FinUpgr.Type
                            else
                                typevar:=FinUpgr.type::" ";
                            currstation:=EmpVar."Current Station";
                        end;
                    end;
                }
                field("Employee Name";EmpNameVar)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Designation;DesigngVar)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date of application upload(Current Date)";DatAppUpdate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                //Anmol start
                field("Effective Date Of MACP";Rec."Effective Date Of MACP")
                {
                    ApplicationArea = all;
                }
                //Anmol end
                field("Type";typevar)
                {
                    ApplicationArea = All;
                    Editable = Updatebtn;
                }
                field("Current Station";currstation)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()var FinUgApp: Record "Financial Upg Application";
                HistoryRec: Record "Financial Upg App history";
                InStream1: InStream;
                OutStream1: OutStream;
                begin
                    if Rec.IsEmpty then Error('No record to submit.');
                    if(typevar <> typevar::" ") or (Tempblob.HasValue())then begin
                        if not Confirm('You are about to change existing data. Previous Type and attachment will be removed. Continue?', false)then Error('Update cancelled.');
                        // Store history before updating
                        HistoryRec.Init();
                        HistoryRec."HRMS ID":=Rec."HRMS ID";
                        HistoryRec."Date of application upload":=Today;
                        HistoryRec.Type:=typevar;
                        HistoryRec."Current Station":=currstation;
                        HistoryRec."Application file name":=fileName;
                        if Tempblob.HasValue()then begin
                            HistoryRec."Application file".CreateOutStream(OutStream1);
                            Tempblob.CreateInStream(InStream1);
                            CopyStream(OutStream1, InStream1);
                        end;
                        HistoryRec."Modified Date Time":=CurrentDateTime;
                        HistoryRec."User Id":=UserId;
                        HistoryRec.Insert(true);
                        // Clear existing attachment
                        Clear(Tempblob);
                        Clear(fileName);
                    end;
                    Updatebtn:=true;
                    Rec.Modify(true);
                    Message('Training record submitted for HRMS ID: %1', Rec."HRMS ID");
                end;
            }
            action("Upload Application")
            {
                ApplicationArea = All;
                Image = Add;

                trigger OnAction()var filePath: Text;
                txt: Text;
                flname: Text;
                begin
                    fileName:=Filemgm.BLOBImportWithFilter(Tempblob, 'Upload File', '', 'All Files (*.*)|*.pdf*', '.pdf');
                    ins:=Tempblob.CreateInStream();
                    if Tempblob.Length() > 3000000 then Error('File size must be less than or equal to 3MB')
                    else
                        Message('File uploaded');
                end;
            }
            action("Download Document")
            {
                ApplicationArea = All;
                Image = Download;

                trigger OnAction()var FilemngCU: Codeunit "File Management";
                begin
                    if Tempblob.Length() > 0 then fileName:=FilemngCU.BLOBExport(Tempblob, 'Application_' + HRMSID + '.pdf', true)
                    else
                        Error('Document Not found');
                end;
            }
            action("Apply")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Save;

                trigger OnAction()var FinanceUpgradRecLVar: Record "Financial Upg Application";
                begin
                    if Confirm('Do you want to submit the current Document?', false)then begin
                        FinanceUpgradRecLVar.Reset();
                        FinanceUpgradRecLVar.Init();
                        FinanceUpgradRecLVar.Validate("HRMS ID", HRMSID);
                        FinanceUpgradRecLVar."Date of application upload":=DatAppUpdate;
                        FinanceUpgradRecLVar.Type:=typevar;
                        FinanceUpgradRecLVar."Current Station":=currstation;
                        FinanceUpgradRecLVar."Application file name":=fileName;
                        if fileName <> '' then begin
                            FinanceUpgradRecLVar."Application file".CreateOutStream(outs);
                            CopyStream(outs, ins);
                        end;
                        FinanceUpgradRecLVar.Insert(true);
                        Message('Document Submit.');
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }
    var fileName: Text;
    Filemgm: Codeunit "File Management";
    Tempblob: Codeunit "Temp Blob";
    ins: InStream;
    outs: OutStream;
    HRMSID: code[20];
    EmpNameVar: text[50];
    DatAppUpdate: Date;
    typevar: Option " ", MACP, RACP;
    DesigngVar: Code[20];
    currstation: Text[50];
    Updatebtn: Boolean;
}
