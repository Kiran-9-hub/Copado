public class handler_class13 {
    public static void Updatedescription(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        List<Account> accdescription = new List<Account>();

        for(Account acc : newAccounts) {
            Account oldAcc = oldAccountMap.get(acc.Id);
            if(acc.Description != oldAcc.Description) {
                accdescription.add(new Account(Id = acc.Id, Description = acc.Description));
            }
        }

        if(!accdescription.isEmpty()) {
            update accdescription;
        }
    }
}