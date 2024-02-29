xmlport 50000 "Customer XML"
{
    Caption = 'Export Customers to XML';
    Direction = EXport;
    Format = xml;


    schema
    {
        textelement(Customer)
        {
            tableelement(Customers; Customer)
            {
                fieldattribute(Number; Customers."No.")
                {

                }
                fieldattribute(Language; Customers."Language Code")
                {

                }
                fieldelement(Name; Customers.Name)
                {

                }
                fieldelement(PhoneNumber; Customers."Phone No.")
                {

                }
                textelement(Address)
                {
                    XmlName = 'Adress';
                    fieldattribute(Address; Customers.Address)
                    {

                    }
                    fieldattribute(PostCode; Customers."Post Code")
                    {

                    }
                    fieldattribute(city; Customers.city)
                    {

                    }
                }
            }
        }
    }



    var
        myInt: Integer;
}