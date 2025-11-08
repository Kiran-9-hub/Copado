@isTest
private class FieldChangeViewerControllerTest {

    @testSetup
    static void setupTestData() {						
        // Insert Field_Change__c test data
        List<Field_Change__c> changes = new List<Field_Change__c>{
            new Field_Change__c(
                Object_Name__c = 'Account',
                Field_Name__c = 'Name',
                Old_Value__c = 'OldName',
                New_Value__c = 'NewName',
                Change_Date__c = Date.today().addDays(-2)
            ),
            new Field_Change__c(
                Object_Name__c = 'Account',
                Field_Name__c = 'Phone',
                Old_Value__c = '12345',
                New_Value__c = '67890',
                Change_Date__c = Date.today()
            ),
            new Field_Change__c(
                Object_Name__c = 'Contact',
                Field_Name__c = 'Email',
                Old_Value__c = 'a@test.com',
                New_Value__c = 'b@test.com',
                Change_Date__c = Date.today()
            )
        };
        insert changes;
    }

    @isTest
    static void testGetFieldChanges_WithObjectOnly() {
        // ✅ No fieldName filter to fetch all Account field changes
        List<Field_Change__c> results = FieldChangeViewerController.getFieldChanges('Account', null, null, null);
        System.assertEquals(2, results.size(), 'Should return 2 Account records.');

        for (Field_Change__c fc : results) {
            System.assertEquals('Account', fc.Object_Name__c, 'All records should be for Account');
        }
    }

    @isTest
    static void testGetFieldChanges_WithObjectAndField() {
        List<Field_Change__c> results = FieldChangeViewerController.getFieldChanges('Account', 'Phone', null, null);
        System.assertEquals(1, results.size(), 'Should return 1 Account.Phone record.');
        System.assertEquals('Phone', results[0].Field_Name__c);
    }

    @isTest
    static void testGetFieldChanges_WithDateRange() {
        Date start = Date.today().addDays(-3);
        Date e = Date.today().addDays(-1);
        List<Field_Change__c> results = FieldChangeViewerController.getFieldChanges('Account', null, start, e);
        System.assertEquals(1, results.size(), 'Should return 1 record from date range.');
        System.assertEquals('Name', results[0].Field_Name__c);
    }




}