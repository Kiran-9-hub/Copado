public with sharing class contactclass {
    @AuraEnabled (cacheable=true)
    public static List<Contact> getContacts(){
        try {
            return[SELECT AccountId,Id, FirstName,LastName FROM Contact  ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}