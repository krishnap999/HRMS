page 33065736 "Employee Training Input"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

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
                    TableRelation = Employee."No." where("SLCM Employee"=const(false));

                    trigger onValidate()var Employee: Record 5200;
                    begin
                        Employee.Reset();
                        Employee.SetRange("No.", HRMSID);
                        If Employee.FindFirst()then begin
                            Name:=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            Designation:=Employee.Designation;
                        end;
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
                field("Type Of Training";TypeOfTraining)
                {
                    ApplicationArea = All;

                    trigger OnValidate()begin
                        if TypeOfTraining = TypeOfTraining::Other then SpefyEnable:=true
                        else
                            SpefyEnable:=false;
                    end;
                }
                field("Specify Training";SpecifiedTypeTrain)
                {
                    Editable = SpefyEnable;
                    ApplicationArea = All;
                    Caption = 'Specify type of Training';
                }
                field("Course Name";CourseName)
                {
                    ApplicationArea = All;
                    Caption = 'Traning Course Title';
                }
                field("Training Starting Date";StartDate)
                {
                    ApplicationArea = All;
                }
                field("Training Ending Date";EndDate)
                {
                    ApplicationArea = All;

                    trigger Onvalidate()var begin
                        DurationOfTraining:=(EndDate - StartDate) + 1;
                    end;
                }
                field("Duration Of Training";DurationOfTraining)
                {
                    ApplicationArea = All;
                    Caption = 'Duration Of Training(Days)';
                }
                field("Conducted By";ConductedBy)
                {
                    ApplicationArea = All;
                }
                field("Training Location";TrainingLocation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Upload Document")
            {
                ApplicationArea = All;
                Image = Add;

                trigger OnAction()var filePath: Text;
                txt: Text;
                flname: Text;
                begin
                    fileName:=Filemgmt.BLOBImportWithFilter(Tempblob, 'Upload File', '', 'All Files (*.*)|*.pdf*', '.pdf');
                    Instream1:=Tempblob.CreateInStream();
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
            action("Submit")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()begin
                    EmployeeTrainingHist.Init();
                    EmployeeTrainingHist."HRMS ID":=HRMSID;
                    EmployeeTrainingHist.Name:=Name;
                    EmployeeTrainingHist.Designation:=Designation;
                    EmployeeTrainingHist."Type Of Training":=TypeOfTraining;
                    EmployeeTrainingHist."Course Name":=CourseName;
                    EmployeeTrainingHist."Start Date":=StartDate;
                    EmployeeTrainingHist.EndDate:=EndDate;
                    EmployeeTrainingHist."Duration Of Training":=(EndDate - StartDate) + 1;
                    EmployeeTrainingHist."Conducted By":=ConductedBy;
                    EmployeeTrainingHist."Training Location":=TrainingLocation;
                    EmployeeTrainingHist."Certificate FileName":=fileName;
                    if fileName <> '' then begin
                        EmployeeTrainingHist.Certificate.CreateOutStream(Outstream1);
                        CopyStream(Outstream1, Instream1);
                    end;
                    EmployeeTrainingHist.Insert(true);
                    Message('Training Assigned Successfully to employee %1', HRMSID);
                    CurrPage.Close();
                end;
            }
        }
    }
    var HRMSID: Code[20];
    Name: Text[90];
    Designation: Text[30];
    TypeOfTraining: Enum "Type Of Training";
    CourseName: Text[30];
    StartDate: Date;
    EndDate: Date;
    DurationOfTraining: Integer;
    ConductedBy: Text[30];
    TrainingLocation: Text[30];
    EmployeeTrainingHist: Record "Employee Training History";
    SpecifiedTypeTrain: Text[50];
    SpefyEnable: Boolean;
    fileName: Text;
    Filemgmt: Codeunit "File Management";
    Tempblob: Codeunit "Temp Blob";
    Instream1: InStream;
    Outstream1: OutStream;
}
