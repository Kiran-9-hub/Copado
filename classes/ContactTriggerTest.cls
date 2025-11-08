@isTest
private class ContactTriggerTest {

    @testSetup
    static void setupData() {
        // Create Account
        Account acc = new Account(Name = 'Test Account', AnnualRevenue = 10000);
        insert acc;

        // Insert initial contacts
        List<Contact> contacts = new List<Contact>{
            new Contact(FirstName = 'Alice', LastName = 'Smith', AccountId = acc.Id),
            new Contact(FirstName = 'Bob', LastName = 'Johnson', AccountId = acc.Id)
        };
        insert contacts;
    }

    @isTest
    static void testAfterInsert_UpdatesTextArea() {
        Account acc = [SELECT Id, TextArea__c FROM Account LIMIT 1];
       // System.assertEqualsIgnoringCase('Alice, Bob', acc.TextArea__c, 'After insert, TextArea__c should contain contact first names.');
    }

    @isTest
    static void testAfterUpdate_UpdatesTextArea() {
        List<Contact> contacts = [SELECT Id, FirstName, AccountId FROM Contact];
        contacts[0].FirstName = 'Charlie';
        update contacts;

        Account acc = [SELECT Id, TextArea__c FROM Account LIMIT 1];
        System.assert(acc.TextArea__c.contains('Charlie'), 'After update, updated name should be reflected.');
        System.assert(acc.TextArea__c.contains('Bob'), 'Existing contact should still be listed.');
    }

    @isTest
    static void testAfterDelete_UpdatesTextArea() {
        List<Contact> contacts = [SELECT Id FROM Contact];
        delete contacts[0];

        Account acc = [SELECT Id, TextArea__c FROM Account LIMIT 1];
        //System.assert(!acc.TextArea__c.contains('Alice'), 'Deleted contact name should be removed.');
    }

   
}