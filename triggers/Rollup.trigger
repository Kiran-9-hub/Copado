trigger Rollup on Asset (after insert, after update , after delete) {
    Set<Id> accountIds = new Set<Id>();

    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Asset a : Trigger.new) {
            if (a.AccountId != null) {
                accountIds.add(a.AccountId);
            }
        }
    }

    if (Trigger.isDelete) {
        for (Asset a : Trigger.old) {
            if (a.AccountId != null) {
                accountIds.add(a.AccountId);
            }
        }
    }

    if (!accountIds.isEmpty()) {
        //rollup.M1();
    }
}