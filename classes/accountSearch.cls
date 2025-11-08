public with sharing class accountSearch {
    
    public class AccountWithContact{
        @AuraEnabled public String accountname;
        @AuraEnabled public Integer contactCount;
        
        public AccountWithContact(String accountname, Integer contactCount) {
            this.accountname = accountname;
            this.contactCount = contactCount;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<AccountWithContact> searchCounts(String searchKey) {
        String searchPattern = '%' + searchKey + '%';
        
        List<Account> accounts = [SELECT Id, Name, (SELECT Id FROM Contacts) 
                                  FROM Account 
                                  WHERE Name LIKE :searchPattern];
        
        List<AccountWithContact> accountWithContactList = new List<AccountWithContact>();
        
        for (Account acc : accounts) {
            Integer contactCount = acc.Contacts.size();
            accountWithContactList.add(new AccountWithContact(acc.Name, contactCount));
        }
        
        return accountWithContactList;
    }
}