trigger AccountTrigger on Account (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        FieldChangeTracker.trackChanges(Trigger.old, Trigger.new);
    }
}