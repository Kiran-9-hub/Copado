public class QuoteLineItemService {
    public static void createQuoteLineItem() {
        
        Quote q = [SELECT Id, Pricebook2Id FROM Quote WHERE Name = 'Monthly car service' LIMIT 1];

       
        Product2 p = [SELECT Id FROM Product2 WHERE Name = 'Annual Car Service' LIMIT 1];

       
        PricebookEntry pbe = [
            SELECT Id, Pricebook2Id
            FROM PricebookEntry
            WHERE Pricebook2Id = :q.Pricebook2Id
            AND Product2Id = :p.Id
            AND IsActive = true
            LIMIT 1
        ];

        
        QuoteLineItem qli = new QuoteLineItem();
        qli.QuoteId = q.Id;
        qli.PricebookEntryId = pbe.Id;
        qli.Quantity = 1;
        qli.UnitPrice = 500.00;
        qli.Price_Book__c = pbe.Pricebook2Id; 

        insert qli;
    }
}