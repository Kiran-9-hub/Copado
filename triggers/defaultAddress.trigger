trigger defaultAddress on Account (before insert) {
   defaultAddressCls.trgMethod(trigger.new);
}