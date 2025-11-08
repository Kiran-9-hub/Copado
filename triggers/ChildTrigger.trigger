trigger ChildTrigger on Child__c (after insert, after delete, after update){
    Set<Id> parentIds = new Set<Id>();

    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Child__c child : Trigger.new) {
            if (child.Parent__c != null)
                parentIds.add(child.Parent__c);
        }
    }

    if (Trigger.isDelete) {
        for (Child__c child : Trigger.old) {
            if (child.Parent__c != null)
                parentIds.add(child.Parent__c);
        }
    }

    if (!parentIds.isEmpty()) {
        List<AggregateResult> groupedResults = [SELECT Parent__c, COUNT(Id) total FROM Child__c WHERE Parent__c IN :parentIds GROUP BY Parent__c];

        Map<Id, Integer> parentToCountMap = new Map<Id, Integer>();
        for (AggregateResult ar : groupedResults) {
            parentToCountMap.put((Id) ar.get('Parent__c'), (Integer) ar.get('total'));
        }

        List<Parent__c> parentsToUpdate = new List<Parent__c>();
        for (Id parentId : parentIds) {
            Parent__c p = new Parent__c(Id = parentId);
            p.Total_Children__c = parentToCountMap.containsKey(parentId) ? parentToCountMap.get(parentId) : 0;
            parentsToUpdate.add(p);
        }

        if (!parentsToUpdate.isEmpty()) {
            update parentsToUpdate;
        }
    }
}