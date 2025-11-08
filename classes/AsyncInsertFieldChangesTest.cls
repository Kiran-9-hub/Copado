@isTest
public class AsyncInsertFieldChangesTest {

    @isTest
    static void testQueueableInsert() {
        // Prepare test data
        List<Field_Change__c> changeList = new List<Field_Change__c>();

        for (Integer i = 0; i < 2; i++) {
            Field_Change__c fc = new Field_Change__c(
                Object_Name__c = 'Contact',
                Field_Name__c = 'Email',
                Old_Value__c = 'old@example.com',
                New_Value__c = 'new@example.com',
                Changed_By__c = UserInfo.getUserId(),
                Change_Date__c = Date.today()
            );
            changeList.add(fc);
        }

        // Instantiate and enqueue the job
        AsyncInsertFieldChanges job = new AsyncInsertFieldChanges(changeList);

        Test.startTest();
        System.enqueueJob(job);
        Test.stopTest();

        // Assert the records were inserted
        List<Field_Change__c> inserted = [SELECT Id, Object_Name__c FROM Field_Change__c];
        System.assertEquals(2, inserted.size(), 'Expected 2 Field_Change__c records to be inserted');
        System.assertEquals('Contact', inserted[0].Object_Name__c);
    }
}