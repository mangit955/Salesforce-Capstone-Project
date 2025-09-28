public with sharing class DocumentHandler {
public static void handleBeforeInsert(List<Document__c> newDocs) {
DocumentValidator.validateBeforeInsert(newDocs);
}
}