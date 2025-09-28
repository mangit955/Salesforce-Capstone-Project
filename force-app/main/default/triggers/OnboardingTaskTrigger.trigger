trigger OnboardingTaskTrigger on OnboardingTask__c (after insert, after update) {
    for (OnboardingTask__c t : Trigger.new) {
        if (t.Status__c == 'Ready') {
            WorkdayIntegrationMock.sendTaskToWorkday(t);
        }
    }
}
