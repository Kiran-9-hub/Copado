trigger count_contact on Account (after insert, after delete, after undelete) {
count_contactOnAccount.updateAccountContactCount();
}