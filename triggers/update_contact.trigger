trigger update_contact on Account (after update) {
Handler_class.Updatedcontact(Trigger.new, Trigger.oldMap);
}