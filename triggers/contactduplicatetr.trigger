trigger contactduplicatetr on Contact (before insert,before update) {
ContactClasss.duplicateContactName(Trigger.new);
}