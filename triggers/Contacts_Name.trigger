trigger Contacts_Name on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> accIds = new Set<Id>();

    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Contact con : Trigger.new) {
            if (con.AccountId != null) accIds.add(con.AccountId);
        }
    }

    if (Trigger.isDelete) {
        for (Contact con : Trigger.old) {
            if (con.AccountId != null) accIds.add(con.AccountId);
        }
    }

    if (!accIds.isEmpty()) {
        Map<Id, List<String>> accToConNames = new Map<Id, List<String>>();

        List<Contact> conList = [
            SELECT Id, Name, AccountId
            FROM Contact
            WHERE AccountId IN :accIds
        ];

        for (Contact con : conList) {
            if (!accToConNames.containsKey(con.AccountId)) {
                accToConNames.put(con.AccountId, new List<String>());
            }

            accToConNames.get(con.AccountId).add(con.Name);
        }

        List<Account> accList = new List<Account>();

        for (Id accId : accToConNames.keySet()) {
            Account accData = new Account();
            accData.Id = accId;
            accData.Contact_Names__c = String.join(accToConNames.get(accId), ', ');
            accList.add(accData);
        }

        update accList;
    }
}