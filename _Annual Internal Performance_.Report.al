report 33065700 "Annual Internal Performance"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './AnnualInternalPreformancePreview.rdl';
    Caption = 'Annual Internal Performance Preview';

    dataset
    {
        dataitem("Annual Performance Review";"Annual Performance Review")
        {
            column(HRMS_ID;"HRMS ID")
            {
            }
            column(Name;Name)
            {
            }
            column(Designation;Designation)
            {
            }
            column(Department;Department)
            {
            }
            column(Academic_Year;"Academic Year")
            {
            }
            column(Performance_Rating;"Performance Rating")
            {
            }
            trigger onpreDataItem()begin
            //  If AcademicYear = '' then
            //Error('Please Provide Academic Year for which you want to generate Annaul Performance');
            //"Annual Performance Review".SetRange("Academic Year", AcademicYear);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(AcademicYear;AcademicYear)
                    {
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var AcademicYear: Code[20];
}
