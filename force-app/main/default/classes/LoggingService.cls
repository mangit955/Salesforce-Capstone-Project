public with sharing class LoggingService {
public static void logError(String message, Id relatedRecordId) {
try {
Error_Log__c log = new Error_Log__c();
log.Name = 'ERR-' + Datetime.now().getTime();
log.Error_Message__c = message;
if (relatedRecordId != null) log.Related_Record_Id__c = String.valueOf(relatedRecordId);
insert log;
} catch (Exception ex) {
// Best effort only: avoid throwing from logging
System.debug('LoggingService.logError failed: ' + ex.getMessage());
}
}
}