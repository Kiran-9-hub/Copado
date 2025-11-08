public class database_insert {
    public static void M1(){
        
        Account acc = new Account(Name='Kiran',phone='8917315757',Rating='warm',AnnualRevenue=14795);
        Database.SaveResult sr = Database.insert(acc,false);
        if(sr.isSuccess()){
            system.debug(sr.getId());
        }else{
            for(Database.Error err : sr.getErrors()){
                System.debug(err.getMessage());
            }
        }
    }
}