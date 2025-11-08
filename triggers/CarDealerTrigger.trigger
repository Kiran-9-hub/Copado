trigger CarDealerTrigger on Bike__c (after update) {
        FieldChangeTracker.trackChanges(Trigger.old, Trigger.new);
    }