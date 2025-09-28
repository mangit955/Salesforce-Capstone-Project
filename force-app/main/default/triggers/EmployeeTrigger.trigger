trigger EmployeeTrigger on Employee__c (after insert, after update) {
if (Trigger.isAfter && Trigger.isInsert) {
EmployeeHandler.handleAfterInsert(Trigger.new);
}
if (Trigger.isAfter && Trigger.isUpdate) {
EmployeeHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
}
}