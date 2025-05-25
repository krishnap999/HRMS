page 33065741 "Promotion History List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Promotion History";
    CardPageId = "Promotion History Card";
    Editable = false;
    Caption = 'Employee promotion History list';
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
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
                field("From Designation";rec."From Designation")
                {
                    ApplicationArea = All;
                }
                field("To Designation";rec."To Designation")
                {
                    ApplicationArea = All;
                }
                field("Promotion Order Date";rec."Promotion Order Date")
                {
                    ApplicationArea = All;
                }
                field("Letter NO";rec."Letter NO")
                {
                    ApplicationArea = All;
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
            action("Download Promotion Order")
            {
                ApplicationArea = All;

                trigger OnAction()var FilemngCU: Codeunit "File Management";
                inst: InStream;
                os: OutStream;
                tempblobloc: Codeunit "Temp Blob";
                begin
                    Rec.CalcFields("Promotion Order");
                    if Rec."Promotion Order".HasValue then begin
                        Rec."Promotion Order".CreateInStream(inst);
                        tempblobloc.CreateOutStream(os);
                        CopyStream(os, inst);
                        FilemngCU.BLOBExport(tempblobloc, Rec."HRMS ID" + '_Promotion Order.pdf', true);
                    end
                    else
                        Error('File Not found');
                end;
            }
        }
    }
}
