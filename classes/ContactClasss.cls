public class ContactClasss {
    public static void duplicateContactName(List<Contact> conList) {

        Set<Id> accIds = new Set<Id>();
        Set<String> nameList = new Set<String>();

        for (Contact con : conList) {
            if (con.AccountId != null && con.FirstName != null) {
                accIds.add(con.AccountId);
                nameList.add(con.FirstName);
            }
        }

        List<Contact> existingConList = new List<Contact>();
        
        if (!accIds.isEmpty() && !nameList.isEmpty()) {
            existingConList = [SELECT Id, FirstName, AccountId FROM Contact WHERE FirstName IN :nameList AND AccountId IN :accIds AND Id NOT IN :conList ];
        }
        
        Set<String> existingCombos = new Set<String>();
        for (Contact existing : existingConList) {
            existingCombos.add(existing.AccountId + '-' + existing.FirstName);
        }

        for (Contact con : conList) {
            if (con.AccountId != null && con.FirstName != null) {
                String combo = con.AccountId + '-' + con.FirstName;
                if (existingCombos.contains(combo)) {
                    con.addError('A contact with this name already exists under this Account.');
                }
            }
        }
    }
}