public with sharing class workshopSchedule {

    @AuraEnabled(cacheable=true)
    public static list<Scheduled_Workshop__c> getWorkshopSchedule(id poolId) {
        return [
            select
                Id, Start_Time__c, Registration_Link__c 
            from
                Scheduled_Workshop__c
            where 
                Org_Pool__c =: poolId 
                    and
                Start_Time__c >: System.Now()
                    and
                Registration_Link__c != null
            ];
    }
}
