@IsTest
private class EmployeeHandler {

    @IsTest
    static void testAfterInsertCallsAssigner() {
        // Create a test User for Manager
        User mgr = new User(
            Alias = 'mgrtest2',
            Email='mgr2@test.com',
            EmailEncodingKey='UTF-8',
            LastName='Manager2',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            ProfileId = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1].Id,
            TimeZoneSidKey='GMT',
            UserName='mgruser2'+System.currentTimeMillis()+'@test.com'
        );
        insert mgr;

        Test.startTest();
        // Insert Employee to trigger handler
        Employee__c emp = new Employee__c(
            Name = 'Handler Employee',
            Has_Manager__c = true,
            Manager__c = mgr.Id,
            Department__c = 'HR',
            Email__c = 'handler@test.com'
        );
        insert emp;
        Test.stopTest();

        // Assert that TaskAutoAssigner created tasks
        List<OnboardingTask__c> tasks = [SELECT Id, Employee__c FROM OnboardingTask__c WHERE Employee__c = :emp.Id];
        System.assertEquals(1, tasks.size(), 'Tasks should be created for employee by handler');
    }
}