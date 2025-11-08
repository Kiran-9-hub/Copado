public class Account_data {
    public static void M2(){
        List<Account> acclist=[SELECT id,Name FROM Account];
        for(Account acc:acclist){
            system.debug(acc);
        }
            
    }
}