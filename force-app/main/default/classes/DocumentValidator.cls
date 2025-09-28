public with sharing class DocumentValidator {
public class DocumentValidationException extends Exception {}


// Basic validation based on two fields expected on Document__c:
// Content_Type__c (Text) and File_Size_Bytes__c (Number)
public static void validateBeforeInsert(List<Document__c> newDocs) {
if (newDocs == null || newDocs.isEmpty()) return;


Set<String> allowed = new Set<String>{'pdf','png','jpg','jpeg','docx'};
Integer maxBytes = 5 * 1024 * 1024;


for (Document__c d : newDocs) {
try {
// Using dynamic get to avoid hard compile dependency on custom field presence at runtime.
Object ctObj = d.get('Content_Type__c');
String contentType = ctObj == null ? null : String.valueOf(ctObj);


Object sizeObj = d.get('File_Size_Bytes__c');
Integer sizeBytes = null;
if (sizeObj != null) {
if (sizeObj instanceof Decimal) sizeBytes = ((Decimal)sizeObj).intValue();
else if (sizeObj instanceof Integer) sizeBytes = (Integer)sizeObj;
else sizeBytes = Integer.valueOf(String.valueOf(sizeObj));
}


if (String.isBlank(contentType)) {
d.addError('Missing Content_Type__c on Document record.');
continue;
}


String ext = contentType.replace('.','').toLowerCase();
if (!allowed.contains(ext)) {
d.addError('File type not allowed: ' + contentType);
continue;
}


if (sizeBytes != null && sizeBytes > maxBytes) {
d.addError('File exceeds max size of 5 MB.');
continue;
}


} catch (Exception ex) {
LoggingService.logError('DocumentValidator unexpected error: ' + ex.getMessage(), d.Id);
d.addError('Document validation failed: ' + ex.getMessage());
}
}
}
}