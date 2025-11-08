public class List_Demo {
    public static void ListMethod() {
        List<String> strList = new List<String>(); 
        List<String> strList2 = new List<String>();
        Set<String> strSet = new Set<String>();
        List<String> strList3= new List<String>(); 
        Boolean res;
        
        sObject sobj = [SELECT Id,Name FROM Contact Limit 1];
        
        strList2.sort();

        

        // Adding elements to strList
        strList.add('India');   
        strList.add('India');
        strList.add('USA');     
        strList.add(1, 'UK');   
        strList.add('USA');     
        strList.add(4,'JAPAN'); 

        // Adding elements to strList2
        strList2.add('AUS');
        strList2.add('Uganda');
        strList2.addAll(strList);
        
       // Adding elements to the Set
        strSet.add('TOKIO');
        strSet.add('B');
        strSet.add('AUS');
        strList2.addALL(StrSet);
        
        
        //Clone methode
        strList3=strList.clone();
        
        //Contains methode
        res=strList.contains('USA');
        
        // equals method
         res=strList2.equals(strList2) ;
       

        // outputs
         //System.debug('strList: ' + strList.get(2));  
       //  System.debug('strList2: ' + strList2);
       //  strList2.clear();
        // system.debug('strList2:'+ strList2);
       //  system.debug(strSet);
        // system.debug(strList3);
          //system.debug(res);
          
         // system.debug(sobj.getSObjectType());
          // system.debug(strList.indexof('India'));
          // system.debug(strList2.isEmpty());
           // system.debug(strList.size());
          //  system.debug(strList2.remove(0));
              system.debug(strList2);
    } 
}