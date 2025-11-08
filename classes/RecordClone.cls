public with sharing class RecordClone {
    @AuraEnabled
    public static Id cloneAccountRecord(Id recordId) {
        try {
            Account acc = [
                SELECT Name, Industry, Phone, Website, AnnualRevenue FROM Account WHERE Id = :recordId LIMIT 1];
            
            
            Account clonedAcc = acc.clone(false, true, false, false);
            clonedAcc.Name = acc.Name + ' (Cloned)';

           
            if (clonedAcc.AnnualRevenue == null) {
                clonedAcc.AnnualRevenue = 0;  
            }

            insert clonedAcc;
            return clonedAcc.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Clone failed: ' + e.getMessage());
        }
    }
}