trigger ContactAllContact on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> accountIds = new Set<Id>();

   
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Contact c : Trigger.new) {
            if (c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
    }


    if (Trigger.isDelete) {
        for (Contact c : Trigger.old) {
            if (c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
    }

    if (!accountIds.isEmpty()) {
     
        Map<Id, Integer> contactCounts = new Map<Id, Integer>();
        for (AggregateResult ar : [SELECT AccountId, COUNT(Id) total FROM Contact WHERE AccountId IN :accountIds GROUP BY AccountId]) {
            contactCounts.put((Id)ar.get('AccountId'), (Integer)ar.get('total'));
        }

      
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : accountIds) {
            Integer count = contactCounts.get(accId);
            accountsToUpdate.add(new Account(Id = accId,Total_Contact__c = count != null ? count : 0));
        }

        
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}