global class BatchScheduleSalesContractTasks implements Schedulable
{
    Public static String sched = '0 00 00 * * ?'; // Batch is Scheduled to run Every Day at Midnight
    
     Global static void ScheduleMe()
    {
        BatchScheduleSalesContractTasks SC = new BatchScheduleSalesContractTasks();
		System.schedule('Contract Renewal Job', sched, SC);
    }
    
    Global void execute(SchedulableContext sc)
    {       
        BatchCreateSalesContractTasks b = new BatchCreateSalesContractTasks();
        database.executebatch(b,30);
    }
    
}