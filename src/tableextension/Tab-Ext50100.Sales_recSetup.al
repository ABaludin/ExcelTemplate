tableextension 50100 "Sales_rec-Setup" extends "Sales & Receivables Setup" //MyTargetTableId
{
    fields
    {
        field(50100; "Sales Document Template"; Code[10])
        {
            Caption = 'Sales Document Template';
            DataClassification = CustomerContent;
            TableRelation = "Excel Template".Code;
        }

    }

}