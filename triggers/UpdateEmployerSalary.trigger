trigger UpdateEmployerSalary on Employee__c (after insert, after update, after delete, after undelete) {
    
    Set<Id> employerIds = new Set<Id>();

    
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Employee__c emp : Trigger.new) {
            if (emp.Employer__c != null) {
                employerIds.add(emp.Employer__c);
            }
        }
    }

    if (Trigger.isDelete) {
        for (Employee__c emp : Trigger.old) {
            if (emp.Employer__c != null) {
                employerIds.add(emp.Employer__c);
            }
        }
    }

    
    if (!employerIds.isEmpty()){

    
    List<AggregateResult> aggResults = [SELECT Employer__c, MAX(Salary__c) maxSal, MIN(Salary__c) minSal FROM Employee__c WHERE Employer__c IN :employerIds GROUP BY Employer__c];

    List<Employer__c> employersToUpdate = new List<Employer__c>();

    for (AggregateResult ar : aggResults) {
        Id empId = (Id) ar.get('Employer__c');
        Decimal maxSalary = (Decimal) ar.get('maxSal');
        Decimal minSalary = (Decimal) ar.get('minSal');

        employersToUpdate.add(new Employer__c(Id = empId,Max_Salary__c = maxSalary,Min_Salary__c = minSalary));
    }
    

    if (!employersToUpdate.isEmpty()) {
        update employersToUpdate;
    }
    }
}