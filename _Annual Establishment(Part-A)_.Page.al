page 70502 "Annual Establishment(Part-A)"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Annual Establishment Review Part A';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Establishment Type";EstablType)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Category";EmpCategr)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Category';
                }
                /* field("Dept./Trade/Section"; DeptsectradeVar)
                {
                    ApplicationArea = All;
                    TableRelation = "List of all Dep/trades/Section"."Departments/Trades/Section";

                    trigger OnValidate()
                    var
                        emp: Record Employee;
                    begin
                        if (DesignatVar <> '') and (DeptsectradeVar <> '') then begin
                            UpdatePersonsInPosition(emp);
                        end;
                    end;
                }
                field(Designation; DesignatVar)
                {
                    ApplicationArea = All;
                    TableRelation = Designation.Code;

                    trigger OnValidate()
                    var
                        emp: Record Employee;
                    begin
                        if (DesignatVar <> '') and (DeptsectradeVar <> '') then begin
                            UpdatePersonsInPosition(emp);
                        end;
                    end;
                } */
                /*  field(Designation; DesignatVar)
                 {
                     ApplicationArea = All;
                     TableRelation = Designation.Code;

                     trigger OnValidate()
                     var
                         sacvsvacant: Record "Sanctioned v/s Vacant";
                         emp: Record Employee;
                     begin
                         // Update Persons in Position
                         if (DesignatVar <> '') and (DeptsectradeVar <> '') then begin
                             emp.SetRange(Designation, DesignatVar);
                             emp.SetRange("Dept./Trade/Section", DeptsectradeVar);
                             perSinPoisionVar := emp.Count();
                         end;

                         // Fetch Sanctioned Strength from Sanctioned v/s Vacant table
                         if (DesignatVar <> '') and (DeptsectradeVar <> '') then begin
                             sacvsvacant.SetRange("Department/Trade/Section", DeptsectradeVar);
                             sacvsvacant.SetRange(Designation, DesignatVar);
                             if sacvsvacant.FindFirst() then
                                 scactionStrength := sacvsvacant."Sactioned Strength"
                             else
                                 scactionStrength := 0; // Default to 0 if no record is found
                         end;

                         // Recalculate Vacant Positions
                         VacantPositions := scactionStrength - perSinPoisionVar;
                     end;
                 }

                 field("Dept./Trade/Section"; DeptsectradeVar)
                 {
                     ApplicationArea = All;
                     TableRelation = "List of all Dep/trades/Section"."Departments/Trades/Section";

                     trigger OnValidate()
                     var
                         sacvsvacant: Record "Sanctioned v/s Vacant";
                         emp: Record Employee;
                     begin
                         // Update Persons in Position
                         if (DesignatVar <> '') and (DeptsectradeVar <> '') then begin
                             emp.SetRange(Designation, DesignatVar);
                             emp.SetRange("Dept./Trade/Section", DeptsectradeVar);
                             perSinPoisionVar := emp.Count();
                         end;

                         // Fetch Sanctioned Strength from Sanctioned v/s Vacant table
                         if (DesignatVar <> '') and (DeptsectradeVar <> '') then begin
                             sacvsvacant.SetRange("Department/Trade/Section", DeptsectradeVar);
                             sacvsvacant.SetRange(Designation, DesignatVar);
                             if sacvsvacant.FindFirst() then
                                 scactionStrength := sacvsvacant."Sactioned Strength"
                             else
                                 scactionStrength := 0; // Default to 0 if no record is found
                         end;

                         // Recalculate Vacant Positions
                         VacantPositions := scactionStrength - perSinPoisionVar;
                     end;
                 } */
                field(Designation;DesignatVar)
                {
                    ApplicationArea = All;
                    TableRelation = Designation.Code;

                    trigger OnValidate()var sacvsvacant: Record "Sanctioned v/s Vacant";
                    emp: Record Employee;
                    begin
                        // Update Persons in Position
                        if(DesignatVar <> '') and (DeptsectradeVar <> '')then begin
                            emp.SetRange(Designation, DesignatVar);
                            emp.SetRange("Dept./Trade/Section", DeptsectradeVar);
                            perSinPoisionVar:=emp.Count();
                        end;
                        // Fetch Sanctioned Strength from Sanctioned v/s Vacant table
                        if(DesignatVar <> '') and (DeptsectradeVar <> '')then begin
                            sacvsvacant.SetRange("Department/Trade/Section", DeptsectradeVar);
                            sacvsvacant.SetRange(Designation, DesignatVar);
                            if sacvsvacant.FindFirst()then scactionStrength:=sacvsvacant."Sactioned Strength"
                            else
                                scactionStrength:=0; // Default to 0 if no record is found
                        end;
                        // Recalculate Vacant Positions
                        VacantPositions:=scactionStrength - perSinPoisionVar;
                    end;
                }
                field("Dept./Trade/Section";DeptsectradeVar)
                {
                    ApplicationArea = All;
                    TableRelation = "List of all Dep/trades/Section"."Departments/Trades/Section";

                    trigger OnValidate()var sacvsvacant: Record "Sanctioned v/s Vacant";
                    emp: Record Employee;
                    begin
                        // Update Persons in Position
                        if(DesignatVar <> '') and (DeptsectradeVar <> '')then begin
                            emp.SetRange(Designation, DesignatVar);
                            emp.SetRange("Dept./Trade/Section", DeptsectradeVar);
                            perSinPoisionVar:=emp.Count();
                        end;
                        // Fetch Sanctioned Strength from Sanctioned v/s Vacant table
                        if(DesignatVar <> '') and (DeptsectradeVar <> '')then begin
                            sacvsvacant.SetRange("Department/Trade/Section", DeptsectradeVar);
                            sacvsvacant.SetRange(Designation, DesignatVar);
                            if sacvsvacant.FindFirst()then scactionStrength:=sacvsvacant."Sactioned Strength"
                            else
                                scactionStrength:=0; // Default to 0 if no record is found
                        end;
                        // Recalculate Vacant Positions
                        VacantPositions:=scactionStrength - perSinPoisionVar;
                    end;
                }
                field("Sanctioned Strength";scactionStrength)
                {
                    ApplicationArea = All;
                    Editable = isfilled;

                    trigger OnValidate()begin
                        VacantPositions:=scactionStrength - perSinPoisionVar;
                    end;
                }
                field("Vacant Positions";VacantPositions)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay Scale GP";PayScaleGPVar)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0;
                }
                field("Pay scale 6th pay";PayScale6thVar)
                {
                    ApplicationArea = All;
                }
                field("Pay Scale level 7th pay";PayScale7thVar)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0;
                }
                field("Persons in Position ";perSinPoisionVar)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic Year";ACYvar)
                {
                    Caption = 'Financial Year';
                    ApplicationArea = All;
                    TableRelation = "Financial Year"."Financial Code";
                }
                field("Remark If Any";Remark)
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
            action("Submit")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Save;

                trigger OnAction()var AnnualEstabRevieRec: Record "Annual Establishment Review";
                begin
                    if Confirm('Do you want to submit the current Document?', false)then begin
                        InsertOrUpdateRecord(AnnualEstabRevieRec);
                        Message('Document Submitted.');
                        CurrPage.Close();
                    end;
                end;
            }
            /* action(Update)
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = UpdateShipment;
                ApplicationArea = All;
                ToolTip = 'Update Sanctioned Strength if approved.';

                trigger OnAction()
                var
                    SanctionedVacantRec: Record "Sanctioned v/s Vacant";
                begin
                    // Open the "Sanctioned v/s Vacant" page with filters applied
                    SanctionedVacantRec.SetRange("Department/Trade/Section", DeptsectradeVar);
                    SanctionedVacantRec.SetRange(Designation, DesignatVar);

                    if Page.RunModal(Page::"Sanctioned v/s Vacant", SanctionedVacantRec) = Action::LookupOK then begin
                        // Update the sanctioned strength from the modified record
                        if SanctionedVacantRec.FindFirst() then
                            scactionStrength := SanctionedVacantRec."Sactioned Strength";
                        VacantPositions := scactionStrength - perSinPoisionVar;
                    end;
                end;
            } */
            /* action(Update)
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = UpdateShipment;
                ApplicationArea = All;
                ToolTip = 'Update Sanctioned Strength if approved.';

                trigger OnAction()
                var
                    SanctionedVacantRec: Record "Sanctioned v/s Vacant";
                begin
                    // Apply filters to find the matching record
                    SanctionedVacantRec.SetRange("Department/Trade/Section", DeptsectradeVar);
                    SanctionedVacantRec.SetRange(Designation, DesignatVar);

                    // Open the page with the filtered record
                    if Page.RunModal(Page::"Sanctioned v/s Vacant", SanctionedVacantRec) = Action::LookupOK then begin
                        // Update the sanctioned strength from the modified record
                        if SanctionedVacantRec.FindFirst() then begin
                            scactionStrength := SanctionedVacantRec."Sactioned Strength";
                            VacantPositions := scactionStrength - perSinPoisionVar;
                        end;
                    end;
                end;
            } */
            action(Update)
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = UpdateShipment;
                ApplicationArea = All;
                ToolTip = 'Update Sanctioned Strength if approved.';

                trigger OnAction()var SanctionedVacantRec: Record "Sanctioned v/s Vacant";
                ConfirmationMessage: Label 'Do you have all the approvals from the respected authorities?';
                UserResponse: Boolean;
                begin
                    // Prompt the user for confirmation
                    UserResponse:=Dialog.Confirm(ConfirmationMessage, true);
                    // Proceed only if the user confirms
                    if UserResponse then begin
                        // Apply filters to find the matching record
                        SanctionedVacantRec.SetRange("Department/Trade/Section", DeptsectradeVar);
                        SanctionedVacantRec.SetRange(Designation, DesignatVar);
                        // Open the page with the filtered record
                        if Page.RunModal(Page::"Sanctioned v/s Vacant", SanctionedVacantRec) = Action::LookupOK then begin
                            // Update the sanctioned strength from the modified record
                            if SanctionedVacantRec.FindFirst()then scactionStrength:=SanctionedVacantRec."Sactioned Strength"
                            else
                                scactionStrength:=0;
                            // Recalculate Vacant Positions
                            VacantPositions:=scactionStrength - perSinPoisionVar;
                        end;
                    end
                    else
                    begin
                        // Inform the user that the action has been canceled
                        Message('The action has been canceled. No changes were made.');
                    end;
                end;
            }
        }
    }
    local procedure UpdatePersonsInPosition(var EmployeeRec: Record Employee)begin
        EmployeeRec.Reset();
        EmployeeRec.SetRange(Designation, DesignatVar);
        EmployeeRec.SetRange("Dept./Trade/Section", DeptsectradeVar);
        if EmployeeRec.FindSet()then begin
            perSinPoisionVar:=EmployeeRec.Count();
        end
        else
        begin
            perSinPoisionVar:=0;
        end;
        VacantPositions:=scactionStrength - perSinPoisionVar;
    end;
    local procedure InsertOrUpdateRecord(var AnnualEstabRec: Record "Annual Establishment Review")begin
        AnnualEstabRec.Reset();
        AnnualEstabRec.Init();
        AnnualEstabRec."Establishment Type":=EstablType;
        AnnualEstabRec."Employee Catagory":=EmpCategr;
        AnnualEstabRec."Dept./Trade/Section":=DeptsectradeVar;
        AnnualEstabRec.Designation:=DesignatVar;
        AnnualEstabRec."Pay Scale GP":=PayScaleGPVar;
        AnnualEstabRec."Pay scale 6th pay":=PayScale6thVar;
        AnnualEstabRec."Pay Scale level 7th pay":=PayScale7thVar;
        AnnualEstabRec."Persons in Position ":=perSinPoisionVar;
        AnnualEstabRec."Academic Year":=ACYvar;
        AnnualEstabRec."Sanctioned Strength":=scactionStrength;
        AnnualEstabRec.Remark:=Remark;
        AnnualEstabRec."Institution Name":=InstituName;
        AnnualEstabRec.Insert(true);
    end;
    var EstablType: Option " ", "Part – A (Regular Establishment)", "Part – C (Non-regular Establishment)", "Part – E (Outsourced/ on contract)";
    DesignatVar: Code[20];
    DeptsectradeVar: Text[80];
    PayScaleGPVar: Decimal;
    PayScale6thVar: Text[250];
    PayScale7thVar: Decimal;
    scactionStrength: Integer;
    perSinPoisionVar: Integer;
    ACYvar: Code[20];
    Remark: Text[100];
    InstituName: Text[90];
    EmpCategr: Option "Group A", "Group B", "Group C", "Group D";
    VacantPositions: Integer;
    isfilled: Boolean;
}
