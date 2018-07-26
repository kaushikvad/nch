@istest(SeeAllData=false)
public class BatchCreateSalesContractTasksTest {


    public static testmethod void testfor90() {
        
        system.debug('1');
        User own = [SELECT Id, Sales_Rep_Number__c,SALESREP_ID__c FROM User WHERE Sales_Rep_Number__c LIKE 'USCA%'][0];
        
        Id RecordTypeIdUpdate = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Contract Renewal Task').getRecordTypeId();
        
        Date abc = Date.newInstance(2018, 10, 09);
        Date oldabc = Date.valueOf(abc);
        
        system.debug(''+oldabc);
        
        // Sales_Contract__c sc = [select Id, SalesRep_Number__c, Account__r.Ownerid, Account__r.id, Contract_End_Date__c From Sales_Contract__C where Contract_End_Date__c <= :oldabc][0];
        
        
        Test.startTest();
        
        Account a = new Account();
        a.Name = 'Test Account New';
        a.Type = 'Customer';
        a.Sales_Rep_ID__c=own.SALESREP_ID__c;
        a.NCH_Account_ID__c = 'NAT-9999999';
        insert a;
        
        system.debug('a: ' + a);
        
        
        Sales_Contract__c sc = new Sales_Contract__C();
        sc.SalesRep_Number__c = own.Sales_Rep_Number__c;
        sc.Contract_End_Date__c = oldabc;
        sc.Account__c = a.id;
        sc.Auto_Renewal_Flag__c = false;
		insert sc;
      
        system.debug('sc:'+sc);
        
        BatchCreateSalesContractTasks bupdate = new BatchCreateSalesContractTasks();
        database.executebatch(bupdate,1);     
        
        Test.stopTest();   
        
    }
    
    public static testmethod void testfor60() {
        
        system.debug('1');
        User own = [SELECT Id, Sales_Rep_Number__c,SALESREP_ID__c FROM User WHERE Sales_Rep_Number__c LIKE 'USCA%'][0];
        
        Id RecordTypeIdUpdate = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Contract Renewal Task').getRecordTypeId();
        
        Date abc = Date.newInstance(2018, 09, 09);
        Date oldabc = Date.valueOf(abc);
        
        system.debug(''+oldabc);
        
        // Sales_Contract__c sc = [select Id, SalesRep_Number__c, Account__r.Ownerid, Account__r.id, Contract_End_Date__c From Sales_Contract__C where Contract_End_Date__c <= :oldabc][0];
        
        
        Test.startTest();
        
        Account a = new Account();
        a.Name = 'Test Account New';
        a.Type = 'Customer';
        a.Sales_Rep_ID__c=own.SALESREP_ID__c;
        a.NCH_Account_ID__c = 'NAT-9999999';
        insert a;
        
        system.debug('a: ' + a);
        
        
        Sales_Contract__c sc = new Sales_Contract__C();
        sc.SalesRep_Number__c = own.Sales_Rep_Number__c;
        sc.Contract_End_Date__c = oldabc;
        sc.Account__c = a.id;
        sc.Auto_Renewal_Flag__c = false;
		insert sc;
      
        system.debug('sc:'+sc);
        
        BatchCreateSalesContractTasks bupdate = new BatchCreateSalesContractTasks();
        database.executebatch(bupdate,1);     
        
        Test.stopTest();   
        
    }
    
    
    public static testmethod void testfor30() {
        
        User own = [SELECT Id, Sales_Rep_Number__c,SALESREP_ID__c FROM User WHERE Sales_Rep_Number__c LIKE 'USCA%'][0];
        
        Id RecordTypeIdUpdate = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Contract Renewal Task').getRecordTypeId();
        
        Date abc = Date.newInstance(2018, 07, 31);
        Date oldabc = Date.valueOf(abc);
        
        system.debug(''+oldabc);
        
        
        Test.startTest();
        
        Account a = new Account();
        a.Name = 'Test Account New';
        a.Type = 'Customer';
        a.Sales_Rep_ID__c=own.SALESREP_ID__c;
        a.NCH_Account_ID__c = 'NAT-9999999';
        insert a;
        
        system.debug('a: ' + a);
        
        
        Sales_Contract__c sc = new Sales_Contract__C();
        sc.SalesRep_Number__c = own.Sales_Rep_Number__c;
        sc.Contract_End_Date__c = oldabc;
        sc.Account__c = a.id;
        sc.Auto_Renewal_Flag__c = false;
		insert sc;
      
        system.debug('sc:'+sc);
        
        BatchCreateSalesContractTasks bupdate = new BatchCreateSalesContractTasks();
        database.executebatch(bupdate,1);     
        
        Test.stopTest();   

    }
}