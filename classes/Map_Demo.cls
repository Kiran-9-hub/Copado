public class Map_Demo {
    public static void MapMethodDemo(){
        Map<Integer,String> intToStrmap = new Map<Integer,String>();
        intToStrmap.put(1,'A');
        intToStrmap.put(2,'B');
       
        
        system.debug(intToStrmap);
          intToStrmap.put(2,'C');
        system.debug(intToStrmap.values());
    }
}