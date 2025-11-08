public class dml_retrive {
    public static void M1(){
        List<Account> acclist = [SELECT Id,Name FROM Account WHERE Name!=null];
        for(Account ac:acclist){
            system.debug(acclist);
        }
    }
}