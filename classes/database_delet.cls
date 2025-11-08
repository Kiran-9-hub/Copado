public class database_delet {
    public static void M1(){
        Account acc = [SELECT Id,Name FROM Account WHERE Name = 'Kiran'LIMIT 1];
        Database.DeleteResult   da = Database.delete(acc,false);
        if(da.isSuccess()){
            system.debug(da.getId());
                }else{
                    for(Database.Error er :da.getErrors()){
                        system.debug(er.getMessage());
                    }
                }
    }
}