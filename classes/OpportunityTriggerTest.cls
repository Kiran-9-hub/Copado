@isTest
private class OpportunityTriggerTest {

    @testSetup
    static void setupTrackedFields() {
        // Insert tracked fields into the custom setting
        List<Field_Tracker_Configuration__c> configs = new List<Field_Tracker_Configuration__c>{
            new Field_Tracker_Configuration__c(
                Name = 'Opportunity.Name',
                Object_Name__c = 'Opportunity',
                Field_Name__c = 'Name',
                Is_Critical__c = true
            ),
            new Field_Tracker_Configuration__c(
                Name = 'Opportunity.StageName',
                Object_Name__c = 'Opportunity',
                Field_Name__c = 'StageName',
                Is_Critical__c = false
            )
        };
        insert configs;
    }

    @isTest
    static void testOpportunityFieldChangeTracking() {
        // Step 1: Create and insert an Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Initial Opp',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10)
        );
        insert opp;

        // Step 2: Clone to simulate the "old" record before update
        Opportunity oldOpp = opp.clone(false, true, false, false);

        // Step 3: Modify tracked fields
        opp.Name = 'Updated Opp';
        opp.StageName = 'Qualification';

        // Step 4: Update to trigger the before update logic
        update opp;

        // Step 5: Validate that Field_Change__c records were created
        List<Field_Change__c> changes = [
            SELECT Field_Name__c, Old_Value__c, New_Value__c
            FROM Field_Change__c
            WHERE Record_Id__c = :opp.Id
        ];

        System.assertEquals(2, changes.size(), 'There should be 2 field changes recorded.');

        Set<String> changedFields = new Set<String>();
        for (Field_Change__c change : changes) {
            changedFields.add(change.Field_Name__c);
        }

        System.assert(changedFields.contains('Name'), 'Name field should be tracked');
        System.assert(changedFields.contains('StageName'), 'StageName field should be tracked');
    }
}