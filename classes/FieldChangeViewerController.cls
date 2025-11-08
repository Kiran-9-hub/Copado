public with sharing class FieldChangeViewerController {
    @AuraEnabled(cacheable=true)
    public static List<Field_Change__c> getFieldChanges(String objectName, String fieldName, Date startDate, Date endDate) {
        
        if (String.isBlank(objectName)) {
            throw new AuraHandledException('Object Name is required.');
            
        }

        // Base query
        String query = 'SELECT Id, Object_Name__c, Field_Name__c, Old_Value__c, New_Value__c, Changed_By__r.Name, Change_Date__c ' +
                       'FROM Field_Change__c WHERE Object_Name__c = \'' + String.escapeSingleQuotes(objectName) + '\'';

       
        if (!String.isBlank(fieldName)) {
            query += ' AND Field_Name__c = \'' + String.escapeSingleQuotes(fieldName) + '\'';
        }

       
        if (startDate != null && endDate != null) {
      query += ' AND Change_Date__c >= :startDate AND Change_Date__c <= :endDate';
          }


        query += ' ORDER BY Change_Date__c DESC';

        System.debug('Final Query: ' + query);
        return Database.query(query);
    }
}