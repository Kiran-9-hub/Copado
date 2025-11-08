trigger caseTrigger on Case (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
if(Trigger.isbefore && Trigger.isInsert){
     for(case cs : Trigger.new){
       cs.subject = cs.subject + 'Modified by kiren' + System.now();
     }
}
}