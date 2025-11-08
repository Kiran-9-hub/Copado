public class Studentdetails {
    public static void displayStudent() {
        List<Account> studentList = new List<Account>();

                        // Creating first student
                        Account stu1 = new Account();
                        stu1.name = 'Kiran';
                        stu1.phone = '101';
                        studentList.add(stu1);
                        
                        // Creating second student
                        Account stu2 = new Account();
                        stu2.name = 'Neha';
                        stu2.phone = '102';
                        studentList.add(stu2);
                        
                        // Creating third student
                        Account stu3 = new Account();
                        stu3.name = 'Amit';
                        stu3.phone = '103';
                        studentList.add(stu3);
                         
                        //creating fourth student
                          Account stu4=new Account();
                           stu4.name='Arjun';
                           stu4.phone='125';
                            studentList.add(stu4);

        for(Account acc:studentList){
            system.debug(acc);
        }
        
    } 
    }