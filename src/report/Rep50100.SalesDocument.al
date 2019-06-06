report 50100 "Sales Document"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field ("Document Type"), "Document No." = field ("No.");

                trigger OnAfterGetRecord()
                begin
                    SDocHelper.AddLine("Sales Line");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SDocHelper.InitTemplate();
                SDocHelper.AddHeader("Sales Header");

            end;

            trigger OnPostDataItem()
            begin
                SDocHelper.AddFooter();
                SDocHelper.ExportData();
            end;


        }
    }

    var
        SDocHelper: Codeunit "Sales Document Helper";
}