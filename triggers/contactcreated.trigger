trigger contactcreated on Account (after insert) {
List<Contact> Createdcontact = new List<Contact>();
    for(Account acc : Trigger.new){
        Contact con = new Contact();
        con.LastName='Created when Parent Created';
        con.AccountId=acc.Id;
        con.phone=acc.phone;
        Createdcontact.add(con);  
    }
    if(!Createdcontact.isEmpty()){
        insert Createdcontact;
    }
}