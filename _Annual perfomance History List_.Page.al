page 33066425 "Annual perfomance History List"
{
    ApplicationArea = All;
    Caption = 'Annual Internal perfomance review History List';
    PageType = List;
    SourceTable = "Annual Performance Review";
    UsageCategory = History;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("HRMS ID";Rec."HRMS ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HRMS ID field.';
                }
                field(Name;Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Designation;Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(Department;Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Academic Year";Rec."Academic Year")
                {
                    // Caption = 'Financial Year';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field("Performance Rating";Rec."Performance Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Performance Rating field.';
                }
            }
        }
    }
}
