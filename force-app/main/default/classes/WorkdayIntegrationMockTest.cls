@IsTest
private class WorkdayIntegrationMockTest {
    @IsTest
    static void testSendTask() {
        OnboardingTask__c task = new OnboardingTask__c(
            Name = 'Test Task',
            Employee__c = UserInfo.getUserId(),
            Status__c = 'Ready'
        );
        insert task;

        Test.startTest();
        WorkdayIntegrationMock.sendTaskToWorkday(task);
        Test.stopTest();

        task = [SELECT Status__c FROM OnboardingTask__c WHERE Id = :task.Id];
        System.assertEquals('Sent to Workday', task.Status__c);
    }
}
