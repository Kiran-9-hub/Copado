public class database_update {
    public static void M1(){
        Account acc = [SELECT Id,Name FROM Account WHERE Name='Kiran' LIMIT 1];
        acc.name='Chandan';
        Database.SaveResult sr = Database.update(acc,false);
        if(sr.isSuccess()){
            system.debug(sr.getId());
                }else{
                    for(Database.Error er : sr.getErrors()){
                        system.debug(er.getMessage());
                    }
                }
    }
}