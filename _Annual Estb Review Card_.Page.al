page 70505 "Annual Estb Review Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Annual Establishment Review";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Sl.No";Rec."Sl.No")
                {
                    ApplicationArea = All;
                }
                field("Establishment Type";Rec."Establishment Type")
                {
                    ApplicationArea = All;
                }
                field("Post Group";Rec."Post Group")
                {
                    ApplicationArea = All;
                }
                Field("Dept./Trade/Section";Rec."Dept./Trade/Section")
                {
                    ApplicationArea = All;
                }
                field(Designation;Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Pay Scale GP";Rec."Pay Scale GP")
                {
                    ApplicationArea = All;
                }
                field("Pay scale 6th pay";Rec."Pay scale 6th pay")
                {
                    ApplicationArea = All;
                }
                field("Sanctioned Strength";Rec."Sanctioned Strength")
                {
                    ApplicationArea = All;
                }
                field("Persons in Position ";Rec."Persons in Position ")
                {
                    ApplicationArea = All;
                }
                field("Vacancy Position ";rec."Vacancy Position ")
                {
                    ApplicationArea = All;
                }
                FIELD("Excess Post";Rec."Excess Post")
                {
                    ApplicationArea = All;
                }
                field("Academic Year";Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                Field(Remark;Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("Institution Name";Rec."Institution Name")
                {
                    ApplicationArea = All;
                }
                field("Employee Catagory";Rec."Employee Catagory")
                {
                    ApplicationArea = All;
                }
                field("Pay Scale level 7th pay";Rec."Pay Scale level 7th pay")
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                end;
            }
        }
    }
}
