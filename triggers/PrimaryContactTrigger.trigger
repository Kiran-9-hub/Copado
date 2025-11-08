trigger PrimaryContactTrigger on Contact (before insert, before update) {
    Set<Id> accountIds = new Set<Id>();

   
    for (Contact con : Trigger.new) {
        if (con.Is_Primary__c == true && con.AccountId != null) {
            accountIds.add(con.AccountId);
        }
    }

    if (!accountIds.isEmpty()) {
       
        List<Contact> existPrimaryContacts = new List<Contact>([SELECT Id, AccountId,Is_Primary__c FROM Contact WHERE AccountId IN :accountIds AND Is_Primary__c = true]) ;

  
        for (Contact existingCon : existPrimaryContacts) {
            existingCon.Is_Primary__c = false;
        }

     
        if (!existPrimaryContacts.isEmpty()) {
            update existPrimaryContacts;
        }
    }
}