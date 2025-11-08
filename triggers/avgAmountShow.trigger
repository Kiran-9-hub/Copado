trigger avgAmountShow on Contact (after insert, after update, after delete, after undelete) {
avgAmountCls.avgAmountMethod(Trigger.isDelete ? Trigger.old : Trigger.new);
}