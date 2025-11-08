@isTest
private class CarDealerTriggerTest {

    @testSetup
    static void setupTrackedFields() {
        // Insert a single tracked field config for Bike__c.Name
        Field_Tracker_Configuration__c config = new Field_Tracker_Configuration__c(
            Name = 'Bike__c.Name',
            Object_Name__c = 'Bike__c',
            Field_Name__c = 'Name',
            Is_Critical__c = true
        );
        insert config;
    }

    @isTest
    static void testBikeNameChangeTracking() {
        // Step 1: Insert a Bike__c record
        Bike__c bike = new Bike__c(Name = 'Hero Splendor');
        insert bike;

        // Step 2: Change the Name field to trigger tracking
        bike.Name = 'Hero Xtreme';
        update bike;

        // Step 3: Verify the field change record is inserted
        List<Field_Change__c> changes = [
            SELECT Field_Name__c, Old_Value__c, New_Value__c, Object_Name__c
            FROM Field_Change__c
            WHERE Record_Id__c = :bike.Id
        ];

        System.assertEquals(1, changes.size(), 'Exactly one field change should be recorded.');
        System.assertEquals('Name', changes[0].Field_Name__c, 'The changed field should be Name.');
        System.assertEquals('Bike__c', changes[0].Object_Name__c, 'Object should be Bike__c.');
        System.assertEquals('Hero Splendor', changes[0].Old_Value__c);
        System.assertEquals('Hero Xtreme', changes[0].New_Value__c);
    }
}