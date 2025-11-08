public class FieldChangeTracker {
    public static void trackChanges(List<SObject> oldList, List<SObject> newList) {
        // Maps to store tracking configurations
        Map<String, Set<String>> trackedMap = new Map<String, Set<String>>(); // Object -> Set of tracked fields
        Map<String, Map<String, Boolean>> criticalMap = new Map<String, Map<String, Boolean>>(); // Object -> (Field -> isCritical)

        // 🔁 Load tracked fields from Custom Setting
       for (Field_Tracker_Configuration__c config : [
    SELECT Object_Name__c, Field_Name__c, Is_Critical__c
    FROM Field_Tracker_Configuration__c
     ]) {
    String objName = config.Object_Name__c;
    String fieldName = config.Field_Name__c;

    if (!trackedMap.containsKey(objName)) {
        trackedMap.put(objName, new Set<String>());
        criticalMap.put(objName, new Map<String, Boolean>());
    }

    trackedMap.get(objName).add(fieldName);
    criticalMap.get(objName).put(fieldName, config.Is_Critical__c);
}
        System.debug('🚦 Tracked Fields Loaded: ' + trackedMap);

        List<Field_Change__c> changes = new List<Field_Change__c>();

        for (Integer i = 0; i < newList.size(); i++) {
            SObject oldRec = oldList[i];
            SObject newRec = newList[i];

            // Get the object API name dynamically
            String objName = newRec.getSObjectType().getDescribe().getName();

            if (!trackedMap.containsKey(objName)) {
                System.debug('⛔ Skipping untracked object: ' + objName);
                continue;
            }

            for (String field : trackedMap.get(objName)) {
                Object oldVal = oldRec.get(field);
                Object newVal = newRec.get(field);

                // Normalize to strings for comparison
                String oldStr = oldVal == null ? null : String.valueOf(oldVal).trim();
                String newStr = newVal == null ? null : String.valueOf(newVal).trim();

                // Compare field values
                if (oldStr != newStr && (oldStr == null || !oldStr.equals(newStr))) {
                    Boolean isCritical = criticalMap.get(objName).get(field);

                    System.debug('📌 Field change detected!');
                    System.debug('Object: ' + objName);
                    System.debug('Field: ' + field);
                    System.debug('Old: ' + oldStr + ', New: ' + newStr);

                    // Add to change log
                    changes.add(new Field_Change__c(
                        Object_Name__c = objName,
                        Record_Id__c = newRec.Id,
                        Field_Name__c = field,
                        Old_Value__c = oldStr,
                        New_Value__c = newStr,
                        Change_Date__c = Date.today(),
                        Changed_By__c = UserInfo.getUserId(),
                        Is_Critical__c = isCritical
                    ));
                }
            }
        }

        // 🔁 Insert all change records if any
        if (!changes.isEmpty()) {
            insert changes;
            System.debug('🗂️ Field change records inserted: ' + changes.size());
        }
    }
}