trigger DocumentTrigger on Document__c (before insert) {
if (Trigger.isBefore && Trigger.isInsert) {
DocumentHandler.handleBeforeInsert(Trigger.new);
}
}