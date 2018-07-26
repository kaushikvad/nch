@istest(SeeAllData=true)
public class BatchScheduleSalesContractTasksTest
{
  public static testmethod void test() 
  {  
    Test.startTest();
    String CRON_EXP = '0 0 0 3 9 ? 2022';
    String jobId = System.schedule('BatchScheduleSalesContractTasksTest', CRON_EXP, new BatchScheduleSalesContractTasks());
    CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId]; 
    System.assertEquals(0, ct.TimesTriggered); 
    system.debug('Next Time: ' + String.valueOf(ct.NextFireTime)); 
    System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));   
      
    BatchScheduleSalesContractTasks.ScheduleMe();
    Test.stopTest();    
  }
}