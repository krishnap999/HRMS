page 50106 "Sanctioned v/s Vacant" //sai
{
    PageType = Card;
    // ApplicationArea = All;
    //UsageCategory = Administration;
    SourceTable = "Sanctioned v/s Vacant";
    Caption = 'Sanctioned Post';
    DeleteAllowed = false;

    Editable = true;
    // Editable = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Sanctioned Post No."; Rec."Sanctioned Post No.")
                {
                    ToolTip = 'Specifies the value of the Sanctioned Post No. field.', Comment = '%';
                    Editable = ATtachc;
                }
                field("Department/Trade/Section"; Rec."Department/Trade/Section")
                {
                    ToolTip = 'Specifies the value of the Department/Trade/Section field.', Comment = '%';
                    Editable = EditBolean;
                }
                field(Designation; Rec.Designation)
                {
                    Editable = EditBolean;
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                }
                field("Sactioned Strength"; Rec."Sactioned Strength")
                {
                    Editable = ATtachB;
                    ToolTip = 'Specifies the value of the Sactioned Strength field.', Comment = '%';
                }
                field("Uploaded Document"; Rec."Uploaded Document")
                {
                    Editable = ATtachB;
                    ToolTip = 'Specifies the value of the Uploaded Document field.', Comment = '%';
                }
                field("Approval No."; Rec."Approval No.")
                {
                    Editable = ATtachB;
                    ToolTip = 'Specifies the value of the Approval No. field.', Comment = '%';

                    trigger OnValidate()
                    var
                        myInt: Integer;
                        aprovalno2: Integer;
                    begin
                        // ATtachc := false;
                    end;
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    Editable = ATtachB;
                    ToolTip = 'Specifies the value of the Financial Year field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = ATtachB;
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                /* field("Sactioned Strength2"; Rec."Sactioned Strength2")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                            strength:Integer;
                        begin
                            if booleanback = false then begin
                                Rec."Sactioned Strength2" := rec."Sactioned Strength";
                            end;
                        end;
                    }
                    field("Approval 2 "; Rec."Approval 2 ")
                    {
                        ApplicationArea = all;
                        Visible = false;

                    } */
            }
        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50121), "No." = FIELD("Sanctioned Post No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Update)
            {
                trigger OnAction()
                begin
                    ATtachB := true;
                    //  ATtachc := true;
                    rec.Remarks := '';
                    rec.submit := false;
                    //  rec."Approval No." := '';
                    //    rec."Sactioned Strength" := 0;
                    rec.Modify();
                    coniforBol := false;
                    //  rec.Rename(rec."Sanctioned Post No.", 0);
                end;
            }
            /*   action(Attachments)
              {
                  Promoted = true;
                  PromotedOnly = true;
                  PromotedCategory = Process;
                  Image = Attach;
                  ApplicationArea = all;
                  ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                  Enabled = ATtachB;
                  trigger OnAction()
                  var
                      DocumentAttachmentDetails: Page "Document Attachment Details";
                      RecRef: RecordRef;
                  begin
                      RecRef.GetTable(Rec);
                      DocumentAttachmentDetails.OpenForRecRef(RecRef);

                      DocumentAttachmentDetails.RunModal();
                  end;
              }

             */
            action(Attachments) //sai
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = Attach;
                ApplicationArea = All;
                Enabled = ATtachB;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachment: Record "Document Attachment";
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec); // Converts the current Rec (record) into a RecordRef.
                    DocumentAttachmentDetails.OpenForRecRef(RecRef); // Opens the attachment page linked to this RecRef.
                    DocumentAttachmentDetails.RunModal(); // Displays the page modally to user to add/view attachments.
                end;
            }
            action(SubmitToHistory) //sai
            {
                ApplicationArea = All;
                Caption = 'Submit';
                Image = SendTo;

                trigger OnAction()
                var
                    Vacant: Record "Sanctioned v/s Vacant";
                    sanctionedG: Integer;
                    approvlg: Integer;
                    DocumentAttachment, DocumentAttachment1 : Record "Document Attachment";
                    SanctionedvsVacantGrec, sanctioned : Record "Sanctioned v/s Vacant";
                    SanctionedHistory: Record "Sanctioned Post History";
                    SanctionedHistory1: Record "Sanctioned Post History";
                    SanctionedHistoryLrec: Record "Sanctioned Post History";
                    SanctionedHistoryLrec1, SanctionedHistoryLrec2 : Record "Sanctioned Post History";
                    Inserted: Boolean;
                    ApprovalInt: Integer;
                begin
                    // Evaluate(ApprovalInt, rec."Approval No.");
                    rec.TestField("Approval No.");
                    rec.TestField("Department/Trade/Section");
                    rec.TestField(Designation);
                    rec.TestField("Sactioned Strength");
                    rec.TestField("Financial Year");
                    rec.TestField(Remarks);
                    DocumentAttachment.Reset();
                    DocumentAttachment.SetRange("Table ID", Database::"Sanctioned v/s Vacant");
                    DocumentAttachment.SetRange("No.", Rec."Sanctioned Post No.");
                    DocumentAttachment.SetRange("Line No.", rec."Sactioned Strength");
                    if not DocumentAttachment.FindFirst() then begin
                        Error('Attachment is mandotory bedore its submiting');
                    end;
                    /* 
                                        DocumentAttachment.Reset();
                                        DocumentAttachment.SetRange("Table ID", Database::"Sanctioned v/s Vacant");
                                        DocumentAttachment.SetRange("No.", Rec."Sanctioned Post No.");

                                        if DocumentAttachment.FindFirst() then begin
                                            DocumentAttachment1.Reset();
                                            DocumentAttachment1.SetRange("File Name", DocumentAttachment."File Name");
                                            if DocumentAttachment1.FindFirst() then
                                                Error('File is alredy attached with same name %1', DocumentAttachment."File Name");
                                        end; */
                    Inserted := true;
                    ATtachB := false;
                    EditBolean := false;
                    SanctionedHistory.Reset();
                    SanctionedHistory.SetRange("Sanctioned Post No.", Rec."Sanctioned Post No.");
                    if not SanctionedHistory.FindFirst() then begin
                        SanctionedHistory1.Init();
                        SanctionedHistory1."Entry No." := Rec."Approval No.";
                        SanctionedHistory1."Sanctioned Post No." := Rec."Sanctioned Post No.";
                        SanctionedHistory1."Old Sanctioned Strength" := 0; // Optional: replace with logic if needed
                        SanctionedHistory1."New Sanctioned Strength" := Rec."Sactioned Strength";
                        SanctionedHistory1."Department/Trade/Section" := Rec."Department/Trade/Section";
                        SanctionedHistory1."Designation" := Rec."Designation";
                        SanctionedHistory1."Approval No." := Rec."Approval No.";
                        SanctionedHistory1."Modified By" := UserId;
                        SanctionedHistory1."Modified On" := CurrentDateTime;
                        //rec.Sanctioned := true;
                        SanctionedHistory1.Insert(true);
                        AttachMent.CopyAttachments(Rec);
                        booleanr := true;
                        rec.submit := true;
                        rec.submit2 := true;
                        Message('Record Posted Successfully.');
                    end
                    else begin
                        if ApprovalVar = Rec."Approval No." then
                            Error('Record with Entry No. %1 already exists.', rec."Approval No.");

                        SanctionedHistoryLrec.Reset();
                        SanctionedHistoryLrec.SetRange("Sanctioned Post No.", SanctionedHistory."Sanctioned Post No.");
                        if SanctionedHistoryLrec.FindSet() then
                            repeat
                                if (SanctionedHistoryLrec."New Sanctioned Strength" = Rec."Sactioned Strength") and (SanctionedHistoryLrec."Department/Trade/Section" = Rec."Department/Trade/Section") and (SanctionedHistoryLrec.Designation = Rec.Designation) and (SanctionedHistoryLrec."Approval No." = Rec."Approval No.") then begin
                                    Inserted := false;
                                end;
                            until (SanctionedHistoryLrec.Next() = 0) or (not Inserted);
                        if Inserted then begin
                            DocumentAttachment.Reset();
                            DocumentAttachment.SetRange("Table ID", Database::"Sanctioned v/s Vacant");
                            DocumentAttachment.SetRange("No.", Rec."Sanctioned Post No.");
                            if not DocumentAttachment.FindFirst() then begin
                                Error('Attachment is mandotory bedore its submiting');
                            end;
                            SanctionedHistoryLrec1.Init();
                            //   SanctionedHistory1."Entry No." := Rec."Approval No.";
                            SanctionedHistoryLrec1."Sanctioned Post No." := Rec."Sanctioned Post No.";
                            SanctionedHistoryLrec1."Old Sanctioned Strength" := 0;
                            SanctionedHistoryLrec1."New Sanctioned Strength" := Rec."Sactioned Strength";
                            SanctionedHistoryLrec1."Department/Trade/Section" := Rec."Department/Trade/Section";
                            SanctionedHistoryLrec1."Designation" := Rec."Designation";
                            SanctionedHistoryLrec1."Approval No." := Rec."Approval No.";
                            SanctionedHistoryLrec1."Entry No." := SanctionedHistoryLrec1."Approval No.";
                            SanctionedHistoryLrec1."Modified By" := UserId;
                            SanctionedHistoryLrec1."Modified On" := CurrentDateTime;
                            SanctionedHistoryLrec2.Reset();
                            SanctionedHistoryLrec2.SetRange("Sanctioned Post No.", Rec."Sanctioned Post No.");
                            if SanctionedHistoryLrec2.FindLast() then begin
                                SanctionedHistoryLrec1."Old Sanctioned Strength" := SanctionedHistoryLrec2."New Sanctioned Strength";
                            end;
                            AttachMent.CopyAttachments(Rec); //sai created codeunit
                            SanctionedHistoryLrec1.Insert(true);
                            booleanr := true; //sai
                            rec.submit := true;

                            Message('Other Record Updated Successfully.');
                        end;
                    end;
                    IsSubmitted := true;
                    coniforBol := true;
                end;
            }
            action(SanctionedPostHistory) //sai
            {
                ApplicationArea = All;
                Caption = 'Sanctioned Post History';
                Image = History;

                trigger OnAction()
                var
                    SanctionedPostHistoryLrec: Record "Sanctioned Post History";
                    SanctionedPostHistory: Page "Sanctioned Post History";
                begin
                    SanctionedPostHistoryLrec.Reset();
                    SanctionedPostHistoryLrec.SetRange("Sanctioned Post No.", Rec."Sanctioned Post No.");
                    if SanctionedPostHistoryLrec.FindSet() then Page.RunModal(Page::"Sanctioned Post History", SanctionedPostHistoryLrec);
                    /*  SanctionedPostHistory.SetTableView(Rec);
                                 SanctionedPostHistory.RunModal(); */
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage."Attached Documents".Page.Update();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        DocAttach: Record "Document Attachment";
        ExistingRecord: Record "Sanctioned v/s Vacant";
        DuplicateError: Label 'A record with the same Financial Year, Department/Trade/Section, and Designation already exists.';
    begin
        // Check if a record with the same Financial Year, Department/Trade/Section, and Designation already exists
        /*  ExistingRecord.SetRange("Financial Year", Rec."Financial Year");
         ExistingRecord.SetRange("Department/Trade/Section", Rec."Department/Trade/Section");
         ExistingRecord.SetRange(Designation, Rec.Designation);
         if not ExistingRecord.IsEmpty() then
             Error(DuplicateError);

         // Automatically generate a unique "Sanctioned Post No." if it is empty
         if Rec."Sanctioned Post No." = '' then
             Rec."Sanctioned Post No." := Format(CreateGuid());
      */
        // Insert the record into the table
        ///  Rec.Insert(true);   
  // Handle document attachments
        DocAttach.SetRange("No.", Rec."Sanctioned Post No.");
        if DocAttach.FindSet() then Rec."Uploaded Document" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ATtachB := true;
        ATtachc := true;
        EditBolean := true;
        IsSubmitted := false;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //  ATtachB := true;
        sanctionedInt := rec."Sactioned Strength";
        ApprovalVar := Rec."Approval No.";
    end;


    var
        ApprovalVar: Code[30];
        sanctionedInt: Integer;
        IsSubmitted: Boolean;
        //submit: Boolean;
        coniforBol: Boolean;
        ATtachB: Boolean;
        ATtachc: Boolean;
        EditBolean: Boolean;
        AttachMent: Codeunit AttachmentsCodeunit;
        booleanr: Boolean; //sai


    trigger OnClosePage() //sai
    var
        myInt: Integer;
        curec: Record "Sanctioned v/s Vacant";
        sanction: Page "Sanctioned v/s Vacant List"; //sai
    begin
        if curec.Get(Rec."Sanctioned Post No.") then begin

            if (rec."Department/Trade/Section" = '') and
                       (rec.Designation = '') and
                       (rec."Sactioned Strength" = 0) and
                       (rec."Approval No." = '') and
                       (rec."Financial Year" = '') and (rec."Uploaded Document" = true) then begin
                if Confirm('The record %1 was not filled. Do you want to delete it?', false, rec."Sanctioned Post No.") then
                    IsSubmitted := true;
                rec.Delete();
            end;
        end;
        if (rec."Department/Trade/Section" <> '') and
             (rec.Designation <> '') and
             (rec."Sactioned Strength" <> 0) and
             (rec."Approval No." <> '') and
             (rec."Financial Year" <> '') and (rec."Uploaded Document" = true) then begin
            if (rec.submit = false) then begin
                if not Confirm('The record %1 Document has not submited. Do you want to save it?', true, rec."Sanctioned Post No.") then
                    IsSubmitted := false;
                if rec.submit2 = false then begin
                    if IsSubmitted = false then
                        rec.Delete();
                end;

            end;
            if coniforBol = false then begin
                if (rec.submit = true) then begin
                    if not Confirm('The . Do you want to save it Sactioned strength?', true, rec."Sactioned Strength") then
                        rec."Sactioned Strength" := sanctionedInt;
                    rec.Modify();
                    IsSubmitted := true;

                end;
            end;
        end;

    end;



}
