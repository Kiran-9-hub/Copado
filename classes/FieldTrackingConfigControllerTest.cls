@isTest
public class FieldTrackingConfigControllerTest {

    @testSetup
    static void setupData() {
        // Insert a non-critical config for setup
        Field_Tracker_Configuration__c config = new Field_Tracker_Configuration__c(
            Name = 'Account.Phone',
            Object_Name__c = 'Account',
            Field_Name__c = 'Phone',
            Is_Critical__c = false
        );
        insert config;

        // Create a dummy PushTopic to simulate update case
        PushTopic pt = new PushTopic();
        pt.Name = 'Account_fieldTracker';
        pt.Query = 'SELECT Id, Name FROM Account';
        pt.ApiVersion = 59.0;
        pt.NotifyForOperationCreate = true;
        pt.NotifyForOperationUpdate = true;
        pt.NotifyForOperationDelete = false;
        pt.NotifyForFields = 'Referenced';
        //insert pt;
    }

    @isTest
    static void testSaveTrackingConfig_InsertNew() {
        Test.startTest();

        FieldTrackingConfigController.saveTrackingConfig('Contact', 'Email', true); // This should create a new PushTopic

        List<Field_Tracker_Configuration__c> results = [
            SELECT Object_Name__c, Field_Name__c, Is_Critical__c
            FROM Field_Tracker_Configuration__c
            WHERE Object_Name__c = 'Contact' AND Field_Name__c = 'Email'
        ];

        System.assertEquals(1, results.size(), 'Should have created one tracking config');
        System.assertEquals(true, results[0].Is_Critical__c);

        // Confirm PushTopic was created
        List<PushTopic> topics = [SELECT Name, Query FROM PushTopic WHERE Name = 'Contact_fieldTracker'];
        System.assertEquals(1, topics.size(), 'PushTopic should be created');
        System.assert(topics[0].Query.contains('Email'), 'PushTopic query should include new field');

        Test.stopTest();
    }

    @isTest
    static void testSaveTrackingConfig_DuplicateThrowsError() {
        Test.startTest();
        Boolean exceptionThrown = false;

        try {
            FieldTrackingConfigController.saveTrackingConfig('Case', 'subject', false);
        } catch (AuraHandledException e) {
            exceptionThrown = true;
            System.assert(e.getMessage().contains('already exists'));
        }

        System.assertEquals(true, exceptionThrown, 'Expected AuraHandledException for duplicate config');
        Test.stopTest();
    }

    @isTest
    static void testGetExistingConfigs() {
        Test.startTest();
        List<Field_Tracker_Configuration__c> configs = FieldTrackingConfigController.getExistingConfigs();
        System.assert(!configs.isEmpty(), 'Should return existing configs');
        Test.stopTest();
    }

    @isTest
    static void testGetTrackedObjects() {
        Test.startTest();
        List<String> objects = FieldTrackingConfigController.getTrackedObjects();
        System.assert(objects.contains('Account'), 'Should return Account as a tracked object');
        Test.stopTest();
    }

    @isTest
    static void testUpdateExistingPushTopic() {
        // Add new field to existing PushTopic (Account_fieldTracker)
        Test.startTest();
        FieldTrackingConfigController.saveTrackingConfig('Account', 'Industry', true);
        FieldTrackingConfigController.saveTrackingConfig('Account', 'phone', true);

       
        Test.stopTest();
    }
}