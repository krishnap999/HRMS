page 70531 "Employee Training Input"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Training";

    //SourceTableTemporary = true; // Use temporary record to avoid premature insertion
    layout
    {
        area(Content)
        {
            group(General)
            {
                field(HRMSID;Rec."HRMS ID")
                {
                    ApplicationArea = All;
                    Caption = 'HRMS ID';
                    TableRelation = Employee."No." where("SLCM Employee"=const(false));

                    trigger OnValidate()var Employee: Record Employee;
                    ExistingRec: Record "Employee Training";
                    UpdateConfirmQst: Label 'A record for HRMS ID %1 already exists. Do you want to update it?', Comment='%1 = HRMS ID';
                    begin
                        // Populate Name and Designation from Employee table
                        Employee.Reset();
                        Employee.SetRange("No.", Rec."HRMS ID");
                        if Employee.FindFirst()then begin
                            Rec.Name:=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            Rec.Designation:=Employee.Designation;
                        end;
                        // Check for existing record in permanent table
                        ExistingRec.SetRange("HRMS ID", Rec."HRMS ID");
                        if ExistingRec.FindFirst()then begin
                            if Confirm(UpdateConfirmQst, false, Rec."HRMS ID")then begin
                                // Load existing values into temporary record for update
                                Rec.TransferFields(ExistingRec);
                                Rec.Modify();
                                IsUpdateMode:=true; // Flag to indicate update mode
                            end
                            else
                            begin
                                // Clear temporary record to prevent proceeding
                                Rec.Init();
                                Error('Operation canceled. Please select a different HRMS ID or update the existing record.');
                            end;
                        end
                        else
                        begin
                            IsUpdateMode:=false; // New record mode
                        end;
                    end;
                }
                field("Employee Name";Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Designation;Rec.Designation)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Type Of Training";Rec."Type Of Training")
                {
                    ApplicationArea = All;

                    trigger OnValidate()begin
                        if Rec."Type Of Training" = Rec."Type Of Training"::Other then SpefyEnable:=true
                        else
                        begin
                            SpefyEnable:=false;
                            Rec."Spcified Type of training":='';
                        end;
                    end;
                }
                field("Specify Training";Rec."Spcified Type of training")
                {
                    Editable = SpefyEnable;
                    ApplicationArea = All;
                    Caption = 'Specify Type of Training';
                }
                field("Course Name";Rec."Course Name")
                {
                    ApplicationArea = All;
                    Caption = 'Training Course Title';
                }
                field("Training Starting Date";Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("Training Ending Date";Rec.EndDate)
                {
                    ApplicationArea = All;

                    trigger OnValidate()begin
                        if(Rec."Start Date" <> 0D) and (Rec.EndDate <> 0D)then Rec."Duration Of Training":=(Rec.EndDate - Rec."Start Date") + 1
                        else
                            Rec."Duration Of Training":=0;
                    end;
                }
                field("Duration Of Training";Rec."Duration Of Training")
                {
                    ApplicationArea = All;
                    Caption = 'Duration Of Training (Days)';
                    Editable = false;
                }
                field("Conducted By";Rec."Conducted By")
                {
                    ApplicationArea = All;
                }
                field("Training Location";Rec."Training Location")
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
            action(UploadDocument)
            {
                ApplicationArea = All;
                Image = Attach;
                Caption = 'Upload Document';
                ToolTip = 'Upload a PDF document (max 3MB).';

                trigger OnAction()var InStr: InStream;
                OutStr: OutStream;
                begin
                    // Clear previous document
                    if Rec.Certificate.HasValue()then Clear(Rec.Certificate);
                    Clear(FileName);
                    Clear(TempBlob);
                    // Upload PDF file
                    if UploadIntoStream('Upload File', '', 'PDF Files (*.pdf)|*.pdf', FileName, InStr)then begin
                        TempBlob.CreateOutStream(OutStr);
                        CopyStream(OutStr, InStr);
                        if TempBlob.Length() > 3000000 then Error('File size must be less than or equal to 3MB.');
                        Rec.Certificate.CreateOutStream(OutStr);
                        TempBlob.CreateInStream(InStr);
                        CopyStream(OutStr, InStr);
                        Rec."Certificate FileName":=FileName;
                        Rec.Modify();
                        Message('Document %1 uploaded successfully.', FileName);
                    end;
                // No message if user cancels (Back)
                end;
            }
            action(DownloadDocument)
            {
                ApplicationArea = All;
                Image = Download;
                Caption = 'Download Document';
                ToolTip = 'Download the uploaded document.';

                trigger OnAction()var FileMngCU: Codeunit "File Management";
                InStr: InStream;
                begin
                    if Rec.Certificate.HasValue()then begin
                        Rec.Certificate.CreateInStream(InStr);
                        FileMngCU.BLOBExport(TempBlob, 'Application_' + Rec."HRMS ID" + '.pdf', true);
                    end
                    else
                        Error('No document found to download.');
                end;
            }
            action(Update)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Update';
                Image = Edit;
                ToolTip = 'Update the existing training record.';

                trigger OnAction()var PermanentRec: Record "Employee Training";
                HistoryRec: Record "Employee Training History";
                MissingFieldErr: Label 'Please fill in all required fields: %1.';
                NoDocumentErr: Label 'A new document must be uploaded to update the record.';
                NoChangesErr: Label 'No changes detected. Please modify at least one field to update the record.';
                MissingFields: Text;
                begin
                    HistoryRec.Reset();
                    HistoryRec.DeleteAll();
                    HistoryRec.Reset();
                    PermanentRec.DeleteAll();
                    // Validate update mode
                    if not IsUpdateMode then begin
                        Error('No existing record selected for update. Please select an HRMS ID with an existing record.');
                    end;
                    // Validate required fields
                    MissingFields:='';
                    if Rec."HRMS ID" = '' then MissingFields+='HRMS ID, ';
                    if Rec."Start Date" = 0D then MissingFields+='Start Date, ';
                    if Rec.EndDate = 0D then MissingFields+='End Date, ';
                    if Rec."Type Of Training" = Rec."Type Of Training"::Other then if Rec."Spcified Type of training" = '' then MissingFields+='Specify Type of Training, ';
                    if MissingFields <> '' then Error(MissingFieldErr, CopyStr(MissingFields, 1, StrLen(MissingFields) - 2)); // Remove trailing comma and space
                    // Validate document upload
                    if not Rec.Certificate.HasValue()then Error(NoDocumentErr);
                    // Find existing record and check for changes
                    PermanentRec.SetRange("HRMS ID", Rec."HRMS ID");
                    if PermanentRec.FindFirst()then begin
                        // Check if at least one field has changed
                        if(PermanentRec."Type Of Training" = Rec."Type Of Training") and (PermanentRec."Spcified Type of training" = Rec."Spcified Type of training") and (PermanentRec."Course Name" = Rec."Course Name") and (PermanentRec."Start Date" = Rec."Start Date") and (PermanentRec.EndDate = Rec.EndDate) and (PermanentRec."Conducted By" = Rec."Conducted By") and (PermanentRec."Training Location" = Rec."Training Location")then Error(NoChangesErr);
                        // Log to Employee Training History
                        HistoryRec.Init();
                        HistoryRec.TransferFields(PermanentRec);
                        HistoryRec."Entry No":=0; // Auto-increment
                        HistoryRec."Modified By":=UserId;
                        HistoryRec."Modified Date Time":=CurrentDateTime;
                        HistoryRec.Insert(true);
                        // Update permanent record
                        PermanentRec.TransferFields(Rec);
                        PermanentRec."Modified By":=UserId;
                        PermanentRec."Modified Date Time":=CurrentDateTime;
                        PermanentRec.Modify(true);
                        // Clear temporary record and close page
                        Rec.Delete();
                        Commit();
                        Message('Training record updated for HRMS ID: %1', Rec."HRMS ID");
                        CurrPage.Close();
                    end
                    else
                        Error('Existing record for HRMS ID %1 not found.', Rec."HRMS ID");
                end;
            }
            action(Submit)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Submit';
                Image = Save;
                ToolTip = 'Submit a new training record.';

                trigger OnAction()var PermanentRec: Record "Employee Training";
                MissingFieldErr: Label 'Please fill in all required fields: %1.';
                NoDocumentErr: Label 'A document must be uploaded to submit the record.';
                DuplicateErr: Label 'A record for HRMS ID %1 already exists. Use Update to modify it.', Comment='%1 = HRMS ID';
                MissingFields: Text;
                begin
                    // Check for existing record
                    PermanentRec.SetRange("HRMS ID", Rec."HRMS ID");
                    if PermanentRec.FindFirst()then Error(DuplicateErr, Rec."HRMS ID");
                    // Validate required fields
                    MissingFields:='';
                    if Rec."HRMS ID" = '' then MissingFields+='HRMS ID, ';
                    if Rec."Course Name" = '' then MissingFields+='Course Name, ';
                    if Rec."Start Date" = 0D then MissingFields+='Start Date, ';
                    if Rec.EndDate = 0D then MissingFields+='End Date, ';
                    if Rec."Type Of Training" = Rec."Type Of Training"::Other then if Rec."Spcified Type of training" = '' then MissingFields+='Specify Type of Training, ';
                    if MissingFields <> '' then Error(MissingFieldErr, MissingFields);
                    // Validate document upload
                    if not Rec.Certificate.HasValue()then Error(NoDocumentErr);
                    // Insert into permanent table
                    PermanentRec.Init();
                    PermanentRec.TransferFields(Rec);
                    PermanentRec."Modified By":=UserId;
                    PermanentRec."Modified Date Time":=CurrentDateTime;
                    PermanentRec.Insert(true);
                    // Clear temporary record and close page
                    Rec.Delete();
                    Commit();
                    Message('Training record submitted for HRMS ID: %1', Rec."HRMS ID");
                    CurrPage.Close();
                end;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean begin
        // Discard temporary record when closing (Back/Cancel)
        if CloseAction in[Action::OK, Action::Cancel, Action::LookupCancel]then begin
            Clear(TempBlob);
            Clear(FileName);
            exit(true);
        end;
        exit(true);
    end;
    var SpefyEnable: Boolean;
    IsUpdateMode: Boolean;
    FileName: Text;
    TempBlob: Codeunit "Temp Blob";
}
