//Queueable Apex job used to insert field change audit records (Field_Change__c) asynchronously. 
//It’s designed to help reduce the risk of hitting governor limits during large updates — by deferring the insert operation to run after the main trigger logic finishes.

public class AsyncInsertFieldChanges implements Queueable {
    private List<Field_Change__c> changes;

    public AsyncInsertFieldChanges(List<Field_Change__c> changes) {
        this.changes = changes;
    }

    public void execute(QueueableContext context) {
        insert changes;
    }
}