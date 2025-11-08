public class dml_update {
    public static void M1(){
        Account existacc = [SELECT Name,Id FROM Account Where Name='Durga'];
        
        existacc.phone='8117873370';
            update existacc;
        
        system.debug(existacc);
    }
}