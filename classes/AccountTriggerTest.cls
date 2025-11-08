@isTest
private class AccountTriggerTest {

    @testSetup
    static void setupData() {
        // Setup: Insert tracking configurations into the Custom Setting
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
    }

    @isTest
    static void testAccountTrigger_FieldChangeTracking() {
        // Step 1: Create a new Account record
        Account acc = new Account(
            Name = 'Initial Account',
            Phone = '1234567890',
            AnnualRevenue = 50000  // Mandatory field
        );
        insert acc;

        // Step 2: Update tracked fields to trigger change tracking
        acc.Name = 'Updated Account';
        acc.Phone = '0987654321';
        update acc;

        // Step 3: Query Field_Change__c records created by the trigger
        List<Field_Change__c> changes = [
            SELECT Field_Name__c, Old_Value__c, New_Value__c, Object_Name__c, Record_Id__c
            FROM Field_Change__c
            WHERE Record_Id__c = :acc.Id
        ];

        // Step 4: Assert expected changes
        System.assertEquals(2, changes.size(), 'Two field changes (Name & Phone) should be tracked');

        Set<String> trackedFields = new Set<String>();
        for (Field_Change__c change : changes) {
            trackedFields.add(change.Field_Name__c);
        }

        System.assert(trackedFields.contains('Name'), 'Name change should be tracked');
        System.assert(trackedFields.contains('Phone'), 'Phone change should be tracked');
    }
}