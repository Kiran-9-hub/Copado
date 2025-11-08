public class contactcreate {
    public static void createContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            if(acc.Billingcity=='India'){
                Contact con = new Contact();
                con.LastName ='kiran';
                con.email = 'kiran@gmail.com';
                
                conList.add(con);
            }
        }
         if(!conList.isEmpty()){
        update conList ;
    }
    }
   
}