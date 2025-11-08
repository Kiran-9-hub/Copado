@isTest
private class FieldChangeTrackerTest {

    @testSetup
    static void setupTestData() {
        // Insert tracking configurations into the custom setting
        List<Field_Tracker_Configuration__c> configs = new List<Field_Tracker_Configuration__c>{
            new Field_Tracker_Configuration__c(
                Name = 'Account.Name',
                Object_Name__c = 'Account',
                Field_Name__c = 'Name',
                Is_Critical__c = true
            ),
            new Field_Tracker_Configuration__c(
                Name = 'Account.Phone',
                Object_Name__c = 'Account',
                Field_Name__c = 'Phone',
                Is_Critical__c = false
            )
        };
        insert configs;

       
        Account acc = new Account(
            Name = 'Original Account',
            Phone = '1234567890'
           
        );
        insert acc;
    }

    @isTest
    static void testTrackChanges() {
        // Fetch the inserted account record
        Account acc = [SELECT Id, Name, Phone FROM Account LIMIT 1];

        // Clone it to simulate the "old" version
        Account oldAcc = acc.clone(false, true);

        // Update some tracked fields
        acc.Name = 'Updated Account';
        acc.Phone = '0987654321';
        update acc;

        // Get updated version from DB
        Account newAcc = [SELECT Id, Name, Phone FROM Account WHERE Id = :acc.Id];

        Test.startTest();
        FieldChangeTracker.trackChanges(new List<SObject>{ oldAcc }, new List<SObject>{ newAcc });
        Test.stopTest();

        // Assert the Field_Change__c records were created
        List<Field_Change__c> changes = [SELECT Field_Name__c, Old_Value__c, New_Value__c FROM Field_Change__c WHERE Record_Id__c = :acc.Id];
        System.assertEquals(4, changes.size(), 'There should be 2 tracked changes (Name and Phone).');

        Set<String> changedFields = new Set<String>();
        for (Field_Change__c fc : changes) {
            changedFields.add(fc.Field_Name__c);
        }

        System.assert(changedFields.contains('Name'), 'Name field should be tracked');
        System.assert(changedFields.contains('Phone'), 'Phone field should be tracked');
    }
}