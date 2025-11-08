public class Handler_class {
  public static void Updatedcontact(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        List<Contact> updatecontact = new List<Contact>();

        for(Account acc : newAccounts) {
            Account oldAcc = oldAccountMap.get(acc.Id);

            if(acc.Phone != oldAcc.Phone) {
                for(Contact con : [SELECT Id, Phone FROM Contact WHERE AccountId = :acc.Id]) {
                    con.Phone = acc.Phone;
                    updatecontact.add(con);
                }
            }
        }

        if(!updatecontact.isEmpty()) {
            update updatecontact;
        }
    }
}