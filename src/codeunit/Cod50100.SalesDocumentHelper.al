codeunit 50100 "Sales Document Helper"
{
    procedure InitTemplate()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Sales Document Template");

        ExcelBuilder.InitTemplate(SalesSetup."Sales Document Template");
        ExcelBuilder.SetSheet('Sheet1');
    end;

    procedure AddHeader(SalesHeader: Record "Sales Header")
    begin
        ExcelBuilder.AddSection('REPORTHEADER');
        ExcelBuilder.AddDataToSection('DocNo', SalesHeader."No.");
        ExcelBuilder.AddDataToSection('DocDate', Format(SalesHeader."Document Date"));

        TotalQty := 0;
        TotalAmount := 0;
    end;

    procedure AddLine(SalesLine: Record "Sales Line")
    begin
        ExcelBuilder.AddSection('BODY');

        ExcelBuilder.AddDataToSection('ItemNo', SalesLine."No.");
        ExcelBuilder.AddDataToSection('ItemDesc', SalesLine.Description);
        ExcelBuilder.AddDataToSection('Qty', Format(SalesLine.Quantity));
        ExcelBuilder.AddDataToSection('UoM', SalesLine."Unit of Measure Code");
        If SalesLine.Quantity <> 0 then
            ExcelBuilder.AddDataToSection('UnitPrice', Format(SalesLine."Amount Including VAT" / SalesLine.Quantity))
        Else
            ExcelBuilder.AddDataToSection('UnitPrice', '0');
        ExcelBuilder.AddDataToSection('LineAmount', Format(SalesLine."Amount Including VAT"));

        TotalQty += SalesLine.Quantity;
        TotalAmount += SalesLine."Amount Including VAT";
    end;

    procedure AddFooter()
    begin
        ExcelBuilder.AddSection('REPORTFOOTER');

        ExcelBuilder.AddDataToSection('TotalQty', Format(TotalQty));
        ExcelBuilder.AddDataToSection('TotalAmount', Format(TotalAmount));
    end;

    procedure ExportData()
    begin
        ExcelBuilder.ExportData();
    end;

    var
        ExcelBuilder: Codeunit "Excel Report Builder Manager";
        TotalQty: Decimal;
        TotalAmount: Decimal;
}