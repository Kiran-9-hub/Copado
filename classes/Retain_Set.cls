public class Retain_Set {
    public static Void M2(){
        Set<Integer> set1=new Set<Integer>{1,2,3,4};
         Set<Integer> set2=new Set<Integer>{1,2}; 
            set1.retainAll(set2);
        system.debug(set1);
    }
}