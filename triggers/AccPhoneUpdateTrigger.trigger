trigger AccPhoneUpdateTrigger on Account (after update) {
    AccPhoneUpdate.updatePhone(Trigger.new, Trigger.oldMap);
}