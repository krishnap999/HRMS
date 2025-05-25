page 33065737 "Annual Performance Entry"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Annual Internal Performance Review';

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
                            Department:=Employee."Dept./Trade/Section";
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
                field("Department/Trade/Section";Department)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic year";AcademicYaer)
                {
                    ApplicationArea = All;
                    Caption = 'Academic year';
                    TableRelation = "Academic Year".Code;
                }
                field("Performance Review Score";PerformanceRating)
                {
                    MaxValue = 10;
                    MinValue = 0;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Assign Performance")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()begin
                    AnnualPerformanceReview.Init();
                    AnnualPerformanceReview."HRMS ID":=HRMSID;
                    AnnualPerformanceReview.Name:=Name;
                    AnnualPerformanceReview.Designation:=Designation;
                    AnnualPerformanceReview.Department:=Department;
                    AnnualPerformanceReview."Academic Year":=AcademicYaer;
                    AnnualPerformanceReview."Performance Rating":=Format(PerformanceRating);
                    AnnualPerformanceReview.Insert(true);
                    Message('Annual Performance Recorded Successfully For Employee %1', HRMSID);
                    CurrPage.Close();
                end;
            }
        }
    }
    var HRMSID: Code[20];
    Name: Text[90];
    Designation: Text[30];
    Department: Text[30];
    AcademicYaer: Code[10];
    PerformanceRating: Integer;
    AnnualPerformanceReview: Record "Annual Performance Review";
}
