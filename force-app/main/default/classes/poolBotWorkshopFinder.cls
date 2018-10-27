public with sharing class poolBotWorkshopFinder {

    public class WorkshopSearchInput {
        @InvocableVariable(required=true)
        public String SearchPhrase;
    }

    @InvocableMethod(label='Search Workshops' description='Search workshops for your phrase')
    public static list<List<Org_Pool__c>> getWorkshops(List<WorkshopSearchInput> WorkshopSearchInputs) {
        List<List<Org_Pool__c>> output = new List<List<Org_Pool__c>>();
        // List<Org_Pool__c> output = new List<Org_Pool__c>();

        // should only be one from a bot, but who knows.  It's quasi-bulkified
        for (WorkshopSearchInput input: WorkshopSearchInputs){
            // list<WorkshopSearchResults> singleList = new list<WorkshopSearchResults>();
            List<List<SObject>> searchResults = [FIND :input.SearchPhrase IN ALL FIELDS RETURNING Org_Pool__c (Id, Name, Description__c WHERE Public__c = true)];
            List<Org_Pool__c> pools = (Org_Pool__c[])searchResults[0];

            // for(Org_Pool__c pool: pools){
            //     system.debug(pool);

            //     // WorkshopSearchResults item = new WorkshopSearchResults();
            //     // item.Name = pool.Name;
            //     // item.recordId = pool.Id;
            //     // item.Description = pool.Description__c;
            //     // singleList.add(item);
            //     output.add(pool);
            // }
            output.add(pools);
        }

        return output;
    }
}