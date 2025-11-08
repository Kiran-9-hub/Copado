public class NewAccounts {
    public static void M1(){
        List<account> accList = new List<Account>([Select name from Account where name = 'Acme']);
set<account> accset = new Set<Account>();
List<account> accList2 = new List<Account>([Select name from Account where name = 'Acme']);

map<Id,Account> accMAp = new map<Id,Account>([Select id from Account where name = 'Acme']);

for(Account acc:accList){
accset.add(acc);
    
}
        accset.size();

for(Account acc:accList2){
acc.name='changedname';
accset.add(acc);
}
        accset.size();
        
    }
    
}