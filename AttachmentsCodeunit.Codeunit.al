codeunit 50101 AttachmentsCodeunit //sai 
{
    trigger OnRun()begin
    end;
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment";
    var RecRef: RecordRef)var GenJrnlLine: Record "Gen. Journal Line";
    PostedGenJnlLine: Record "Posted Gen. Journal Line";
    sanctionedPost: Record "Sanctioned v/s Vacant";
    PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        case DocumentAttachment."Table ID" of DATABASE::"Sanctioned v/s Vacant": begin
            RecRef.Open(DATABASE::"Sanctioned v/s Vacant");
            if sanctionedPost.Get(DocumentAttachment."No.")then RecRef.GetTable(sanctionedPost);
        end;
        DATABASE::"Sanctioned Post History": begin
            RecRef.Open(DATABASE::"Sanctioned Post History");
            if sanctionedPost.Get(DocumentAttachment."No.")then RecRef.GetTable(sanctionedPost);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment";
    var RecRef: RecordRef;
    var FlowFieldsEditable: Boolean);
    var FieldRef: FieldRef;
    RecNo: Code[20];
    LineNo: Integer;
    begin
        case RecRef.Number of DATABASE::"Sanctioned v/s Vacant": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);
            FieldRef:=RecRef.Field(9);
            LineNo:=FieldRef.Value;
            DocumentAttachment.SetRange("Line No.", LineNo);
            FlowFieldsEditable:=false;
        end;
        DATABASE::"Sanctioned Post History": begin
            DocumentAttachment.SetRange("No.", RecRef.Field(2).Value);
            DocumentAttachment.setRange("Line No.", RecRef.Field(10).Value);
            DocumentAttachment.SetRange("Table ID", Database::"Sanctioned Post History");
            FlowFieldsEditable:=false;
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment";
    var RecRef: RecordRef)var FieldRef: FieldRef;
    RecNo: Code[20];
    LineNo: Integer;
    GenJrnlLine: code[20];
    begin
        case RecRef.Number of DATABASE::"Sanctioned v/s Vacant": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.Validate("No.", RecNo);
            FieldRef:=RecRef.Field(9);
            LineNo:=FieldRef.Value;
            DocumentAttachment.Validate("Line No.", LineNo);
        end;
        DATABASE::"Sanctioned Post History": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecRef.Field(2).Value);
            DocumentAttachment.setRange("Line No.", RecRef.Field(10).Value);
            DocumentAttachment.SetRange("Table ID", Database::"Sanctioned Post History");
        end;
        end;
    end;
    procedure CopyAttachments(OrderConfirmation: Record "Sanctioned v/s Vacant")var DocumentAttachment: Record "Document Attachment";
    PostedOrderConfirmation: Record "Sanctioned Post History";
    NewDocumentAttachment: Record "Document Attachment";
    DCID: Integer;
    begin
        // Find the corresponding posted order
        PostedOrderConfirmation.SetRange("Sanctioned Post No.", OrderConfirmation."Sanctioned Post No.");
        if not PostedOrderConfirmation.FindFirst()then Error('Posted Order for %1 not found.', OrderConfirmation."Sanctioned Post No.");
        // Get next ID for attachments
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"Sanctioned Post History");
        if DocumentAttachment.FindLast()then DCID:=DocumentAttachment.ID + 1
        else
            DCID:=1;
        // Copy attachments
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"Sanctioned v/s Vacant");
        DocumentAttachment.SetRange("No.", OrderConfirmation."Sanctioned Post No.");
        DocumentAttachment.SetRange("Line No.", OrderConfirmation."Approval No.");
        if DocumentAttachment.FindSet()then begin
            repeat NewDocumentAttachment.Init();
                NewDocumentAttachment.TransferFields(DocumentAttachment);
                NewDocumentAttachment."Table ID":=Database::"Sanctioned Post History";
                NewDocumentAttachment."No.":=PostedOrderConfirmation."Sanctioned Post No.";
                NewDocumentAttachment.ID:=DCID;
                NewDocumentAttachment.Insert(true);
                DCID:=DCID + 1;
            until DocumentAttachment.Next() = 0;
        end;
    end;
    var myInt: Integer;
}
