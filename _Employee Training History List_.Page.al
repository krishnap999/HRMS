page 70530 "Employee Training History List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Training History";
    // CardPageId = "Employee Training History Card";
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No";rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("HRMS ID";rec."HRMS ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name";rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Designation;rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Type Of Training";rec."Type Of Training")
                {
                    ApplicationArea = All;
                }
                field("Traing Course Title";rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field("Training Starting Date";rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Training Ending Date";rec.EndDate)
                {
                    ApplicationArea = All;
                }
                field("Duration Of Training";rec."Duration Of Training")
                {
                    ApplicationArea = All;
                }
                field("Conducted By";rec."Conducted By")
                {
                    ApplicationArea = All;
                }
                field("Training Location";rec."Training Location")
                {
                    ApplicationArea = All;
                }
                field("Modified By";Rec."Modified By")
                {
                    ApplicationArea = all;
                }
                field("Modified Date Time";Rec."Modified Date Time")
                {
                    Caption = 'Modified On';
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action("Download")
            {
                ApplicationArea = All;
                Image = Download;

                /* trigger OnAction()
                var
                    FilemngCU: Codeunit "File Management";
                    EmpTraining: Record "Employee Training";
                    inst: InStream;
                    tempblobloc: Codeunit "Temp Blob";
                    FileCount: Integer;
                    outs: OutStream;

                begin
                    EmpTraining.Reset();
                    EmpTraining.SetRange("HRMS ID", Rec."HRMS ID");
                    if EmpTraining.FindSet() then begin
                        FileCount := 0;
                        repeat
                            EmpTraining.CalcFields(Certificate);
                            if EmpTraining.certificate.HasValue then begin
                                FileCount += 1;
                                EmpTraining.Certificate.CreateInStream(inst);
                                tempblobloc.CreateOutStream(outs);
                                CopyStream(outs, inst);
                                FilemngCU.BLOBExport(tempblobloc, 'Employee_training_' + EmpTraining."HRMS ID" + '_' + Format(FileCount) + '.pdf', true);
                            end;
                        until EmpTraining.Next() = 0;
                        if FileCount = 0 then
                            Error('No attachments found for HRMS ID: %1', Rec."HRMS ID");
                        Message('%1 file(s) downloaded successfully.', FileCount);
                    end else
                        Error('No records found for HRMS ID: %1', Rec."HRMS ID");
                end;
            } */
                trigger OnAction()var FilemngCU: Codeunit "File Management";
                Tempblob: Codeunit "Temp Blob";
                begin
                    if Tempblob.Length() > 0 then filenm:=FilemngCU.BLOBExport(Tempblob, 'Application_' + Rec."HRMS ID" + '.pdf', true)
                    else
                        Error('Document Not found');
                end;
            }
        }
    }
    var filenm: Text[50];
}
