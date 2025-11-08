trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> accountIds = new Set<Id>();

  
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Contact con : Trigger.new) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }

    if (Trigger.isDelete) {
        for (Contact con : Trigger.old) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }

    if (!accountIds.isEmpty()) {
       
        List<Contact> relatedContacts = new List<Contact> ([SELECT FirstName, AccountId FROM Contact WHERE AccountId IN :accountIds]);

        
        Map<Id, List<String>> accIdToFirstNames = new Map<Id, List<String>>();
       
        for (Contact con : relatedContacts) {
            
            if (!accIdToFirstNames.containsKey(con.AccountId)) {
                accIdToFirstNames.put(con.AccountId, new List<String>());
            }
           
                accIdToFirstNames.get(con.AccountId).add(con.FirstName);
          
        }

   
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : accountIds) {
            List<String> names = accIdToFirstNames.get(accId);
            String combinedNames = (names != null && !names.isEmpty()) ? String.join(names, ', ') : null;
            accountsToUpdate.add(new Account(Id = accId, TextArea__c = combinedNames));
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}