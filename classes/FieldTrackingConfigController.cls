public with sharing class FieldTrackingConfigController {

    @AuraEnabled
    public static void saveTrackingConfig(String objectName, String fieldName, Boolean isCritical) {
        if (String.isBlank(objectName) || String.isBlank(fieldName)) {
            throw new AuraHandledException('Object Name and Field Name are required.');
        }

        // Check if already exists
        List<Field_Tracker_Configuration__c> existing = [
            SELECT Id FROM Field_Tracker_Configuration__c
            WHERE Object_Name__c = :objectName AND Field_Name__c = :fieldName
        ];

        if (!existing.isEmpty()) {
            throw new AuraHandledException('Configuration already exists.');
        }

        Field_Tracker_Configuration__c setting = new Field_Tracker_Configuration__c(
            Name = objectName + '.' + fieldName,
            Object_Name__c = objectName,
            Field_Name__c = fieldName,
            Is_Critical__c = isCritical
        );

        insert setting;
        if(isCritical == true){
        FieldTrackingConfigController.createOrUpdatePushTopic(objectName,fieldName); 
        }
        
    }
     public static void createOrUpdatePushTopic(String objectName, String fieldName) {
        //String topicPrefix = objectName + '_'; // Prefix used in naming convention
          String topicName = objectName + 'Changes';
        List<PushTopic> existingTopics = [
            SELECT Id, Name, Query
            FROM PushTopic
            WHERE Name =:topicName
        ];

        Boolean fieldAlreadyTracked = false;
         if(!existingTopics.isEmpty()){
             for (PushTopic pt : existingTopics) {
            // Check if this PushTopic already queries this object
            if (pt.Query != null && pt.Query.containsIgnoreCase('FROM ' + objectName)) {
                // Check if field already in query
                if (pt.Query.containsIgnoreCase(fieldName)) {
                    fieldAlreadyTracked = true;
                    System.debug(' Field already tracked in PushTopic: ' + pt.Name);
                    break;
                } else {
                    // Add the field to the query
                    
                    String selectPart = pt.Query.substringBefore('FROM').trim().replace('SELECT', '').trim();                   
                    String newSelect = 'SELECT ' + selectPart + ', ' + fieldName;                    
                    String newQuery = newSelect + ' FROM ' + objectName;				
                    
                    pt.Query = newQuery;
                    update pt;
                    System.debug('🔁 PushTopic updated with new field: ' + pt.Name);
                    fieldAlreadyTracked = true;
                    break;
                }
            }
        }
         }
        

        // Create new PushTopic if not tracked
        if (!fieldAlreadyTracked) {
            //String topicName = objectName + '_' + 'fieldTracker';
            PushTopic newPt = new PushTopic();
            newPt.Name = topicName;
            newPt.Query = 'SELECT Id, ' + fieldName + ' FROM ' + objectName;
            newPt.ApiVersion = 59.0;
            newPt.NotifyForOperationCreate = false;
            newPt.NotifyForOperationUpdate = true;
            newPt.NotifyForOperationDelete = false;
            newPt.NotifyForFields = 'Referenced';
			System.debug('PushTopic to be created: ' + topicName);
            insert newPt;
            
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Field_Tracker_Configuration__c> getExistingConfigs() {
        return [SELECT Id, Name, Object_Name__c, Field_Name__c, Is_Critical__c FROM Field_Tracker_Configuration__c];
    }

    //  New method to get distinct object names from existing configs
    @AuraEnabled(cacheable=true)
    public static List<String> getTrackedObjects() {
        Set<String> objectNames = new Set<String>();
        for (Field_Tracker_Configuration__c conf : [
            SELECT Object_Name__c FROM Field_Tracker_Configuration__c
        ]) {
            if (!String.isBlank(conf.Object_Name__c)) {
                objectNames.add(conf.Object_Name__c);
            }
        }
        return new List<String>(objectNames);
    }
}