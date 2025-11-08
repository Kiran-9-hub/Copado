public class AccPhoneUpdate {
    public static void updatePhone(List<Account> accList, Map<Id, Account> oldMapAcc) {
        List<Contact> contactsToUpdate = new List<Contact>();

        for (Account acc : accList) {
            Account oldAcc = oldMapAcc.get(acc.Id);

            
            if (acc.Phone != oldAcc.Phone) {
                for (Contact con : [
                    SELECT Id, Phone, AccountId
                    FROM Contact
                    WHERE AccountId = :acc.Id
                ]) {
                    con.Phone = acc.Phone;
                    contactsToUpdate.add(con);
                }
            }
        }

        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}