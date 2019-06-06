pageextension 50101 "Sales list" extends "Sales Order List" //MyTargetPageId
{

    actions
    {
        addlast(Reporting)
        {
            action(PrintSalesDocument)
            {
                Image = PrintDocument;
                trigger OnAction()
                var
                    SHeader: Record "Sales Header";
                    SDoc: Report "Sales Document";
                begin
                    CurrPage.SetSelectionFilter(SHeader);
                    SDoc.SetTableView(SHeader);
                    SDoc.Run();
                end;
            }
        }
    }
}