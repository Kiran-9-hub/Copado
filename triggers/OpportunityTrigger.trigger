trigger OpportunityTrigger on Opportunity (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        FieldChangeTracker.trackChanges(Trigger.old, Trigger.new);
    }
}