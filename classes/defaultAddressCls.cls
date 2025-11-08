public class defaultAddressCls {
    public static void trgMethod(List<Account> acclist){
        
        for(Account acc : acclist){
            if(acc.AnnualRevenue>10000){
                acc.BillingStreet = 'Banglore';
             
            }
        }
       
    }
}