public class dml_insert {
    public static void M1(){
        
        List<Account> acc = new List<Account>();
        
        Account ca = new Account();
        ca.Name='Milan';
        ca.Phone='8917459721';
        ca.Rating='warm';
        ca.AnnualRevenue=14795;
        acc.add(ca);
        
        Account acclist = new Account();
        acclist.Name='Kiran';
        acclist.Phone='8917315757';
        acclist.Rating='warm';
        acclist.AnnualRevenue=12795;
        acc.add(acclist);
        
        Account acclist1 = new Account();
        acclist1.Name='Durga';
        acclist1.Phone='4562138795';
        acclist1.Rating='warm';
        acclist1.AnnualRevenue=18795;
        acc.add(acclist1);
        
        insert acc;
        system.debug(acc);
        
    }
}