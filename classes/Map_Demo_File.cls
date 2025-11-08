// public class Map_Demo_File {
//    public static void M1() {
  //      Map<String, List<Account>> Acc = new Map<String, List<Account>>();
    //    List<Account> AcList = [SELECT Id, Name FROM Account];
//
  //      for (Account accc : AcList) {
    //        if (accc != null) {
             //   System.debug(accc);  
      //      } else {
        //        System.debug('Error: Account record is null');
          //  }
    //    }
    //}
//}

public class Map_Demo_File {
    public static void M1(){
        Sobject sobj;
        sobj=new Account(Name='Test',Phone='123456789');
        Account acc=(Account)sobj;
        system.debug(acc);
    }
}