public with sharing class WorkdayIntegrationMock {
    public static void sendTaskToWorkday(OnboardingTask__c task) {
        String body = JSON.serialize(new Map<String, Object>{
            'employeeId' => task.Employee__c,
            'taskName'   => task.Name,
            'status'     => task.Status__c
        });
        System.debug('📤 Mock callout to Workday: ' + body);
        String response = '{"status":"success","taskId":"mock123"}';
        System.debug('📥 Mock response from Workday: ' + response);
        task.Status__c = 'Sent to Workday';
        update task;
    }
}
