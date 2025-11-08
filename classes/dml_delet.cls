public class dml_delet {
    public static void M1(){
        Account deletacc=[SELECT Id,Name FROM Account  WHERE Name='Durga'];
        delete deletacc;
        
        system.debug(deletacc);
    }
}