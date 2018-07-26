global class BatchCreateSalesContractTasks implements Database.Batchable<sObject> 
{    
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        Date d = System.today().addDays(90);
        Date dateStr = Date.newInstance(d.year(),d.month(),d.day());
        String abc = String.valueOf(dateStr);
        system.debug('Todays date: '+abc);
        String query;
        String aqua = 'Chem Aqua';
        List<String> stringValues = new List<String>();
        List<User> u = [select sales_rep_number__c from user where isActive = TRUE and (not profile.name like '%ChemAqua%') and (not name like '%BOOMI%') and sales_rep_number__c <> NULL];// To check if the sales rep is active and name contains BOOMI       
        for(User so: u)
        {   
            if(so.Sales_Rep_Number__c != NULL)
            {
                stringValues.add('\'' + so.Sales_Rep_Number__c + '\'');
            }
        }
        
        if(Test.isRunningTest())
        {
            system.debug('going into test method');
            query = 'SELECT Id,name, Customer_Name__c,X90_day_renewal__c,X60_day_renewal__c,X30_day_renewal__c, Contract_Number__c, SalesRep_Number__c, Account__r.Ownerid,Account__r.Name, Contract_End_Date__c From Sales_Contract__C Where Contract_End_Date__c <= ' + abc + ' and Auto_Renewal_Flag__c = false '; 
            query = query + 'and SalesRep_Number__c IN (' + String.join(stringValues, ',') + ')'+ ' LIMIT 1 ';
        }
        else
        {
            system.debug('error is here!');
            query = 'SELECT Id,name, Customer_Name__c, X90_day_renewal__c, X60_day_renewal__c, X30_day_renewal__c, Contract_Number__c, SalesRep_Number__c, Account__r.Ownerid,Account__r.Name, Contract_End_Date__c From Sales_Contract__C Where Contract_End_Date__c <= ' + abc + ' and Auto_Renewal_Flag__c = false ';
            query = query + 'and SalesRep_Number__c IN (' + String.join(stringValues, ',') + ')';   
        }
        
        system.debug('QUERY: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Sales_Contract__c> scope)
    {
        system.debug('Going into execute');      
        for(Sales_Contract__c sc : scope)
        {
            system.debug('Going into for 2');
            Date d = System.today();
            Date dateStrNew = Date.newInstance(d.year(),d.month(),d.day()); // Today's date in yyyy-MM-dd format
            
            Date query = sc.Contract_End_Date__c;// Retrieving Sales Contract End-Date
            Date efg = date.valueOf(query);
            system.debug('' +efg);
            String newefg = String.valueOf(efg);
            system.debug('' +newefg);
            
            Integer d1 = dateStrNew.daysBetween(efg);            
            system.debug('days between: '+d1);
            
            if((d1 <= 91 && d1 >85) && sc.X90_day_renewal__c == false ) 
            {
                system.debug('Going into 1st if');
                
                Task newTask = new Task(OwnerId =sc.Account__r.Ownerid, WhatId = sc.id,  Description = 'Your Contract expires in 90 Days. Please Renew it manually or choose auto renewal', Priority = 'Normal', Status = 'Not Started', Subject = '90 Day Contract Renewal Reminder for  '+sc.account__r.name, IsReminderSet = false, ReminderDateTime = System.now()+1);
                newTask.RecordTypeId = [Select id, SObjectType, Name from RecordType where Name ='Contract Renewal Task' and SObjectType = 'task' limit 1].id;
                newTask.Type = '90 Day Contract Renewal Reminder';
                newTask.ActivityDate = dateStrNew;
                upsert newTask;
                
                sc.X90_day_renewal__c = true;
                update sc;
                
            }
            else if((d1 <= 61 && d1 >55) && sc.X60_day_renewal__c == false ) 
            {
                system.debug('Going into 2nd if');
                
                Task newTask = new Task(OwnerId =sc.Account__r.Ownerid, WhatId = sc.id,  Description = 'Your Contract expires in 60 Days. Please Renew it manually or choose auto renewal', Priority = 'Normal', Status = 'Not Started', Subject = '60 Day Contract Renewal Reminder for '+sc.account__r.name, IsReminderSet = false, ReminderDateTime = System.now()+1);
                newTask.RecordTypeId = [Select id,SObjectType,Name from RecordType where Name ='Contract Renewal Task' and SObjectType = 'task' limit 1].id;
                newTask.Type = '60 Day Contract Renewal Reminder';
                newTask.ActivityDate = dateStrNew;
                upsert newTask;
                
                sc.X60_day_renewal__c = true;
                update sc;
                
            }
            else if((d1 <= 31 && d1 >0) && sc.X30_day_renewal__c == false )
            {
                system.debug('Going into else');
                
                Task newTask = new Task(OwnerId =sc.Account__r.Ownerid, WhatId = sc.id, Description = 'Your Contract expires in 30 Days. Please Renew it manually or choose auto renewal', Priority = 'High', Status = 'Not Started', Subject = '30 Day Contract Renewal Reminder for '+sc.account__r.name, IsReminderSet = false, ReminderDateTime = System.now()+1);
                newTask.RecordTypeId = [Select id, SObjectType, Name from RecordType where Name ='Contract Renewal Task' and SObjectType = 'task' limit 1].id;
                newTask.Type = '30 Day Contract Renewal Reminder';
                newTask.ActivityDate = dateStrNew;
                upsert newTask;
                
                sc.X30_day_renewal__c = true;
                update sc;
                
            }
            
        }
    }
    global void finish(Database.BatchableContext BC)
    {      
        system.debug('Going into finish');
    }
    
}