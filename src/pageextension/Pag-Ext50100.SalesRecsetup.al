pageextension 50100 "Sales&Rec setup" extends "Sales & Receivables Setup" //MyTargetPageId
{
    layout
    {
        addlast(Templates)
        {
            field("Sales Document Template"; "Sales Document Template")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}