trigger ContacTtriggerF on Contact (after update) {
FieldChangeTracker.trackChanges(Trigger.old, Trigger.new);
}