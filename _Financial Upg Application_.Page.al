page 33066447 "Financial Upg Application"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    // SourceTable = "Financial Upg Application";
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
                    begin
                        if EmpVar.Get(HRMSID)then begin
                            EmpNameVar:=EmpVar."First Name";
                            DesigngVar:=EmpVar.Designation;
                            DatAppUpdate:=Today;
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
                field("Type";typevar)
                {
                    ApplicationArea = All;
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
            action("Upload Aplication")
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
                        Message('File uploded');
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
                    if Confirm('Do you want to submit the current Document ?', false)then begin
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
}
