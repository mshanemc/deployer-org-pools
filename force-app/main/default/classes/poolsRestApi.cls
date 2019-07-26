@RestResource(urlMapping='/pools/*')
global with sharing class poolsRestApi {

    @HttpGet
    global static void getPools() {

        RestRequest req = RestContext.request;
        RestContext.response.addHeader('Content-Type', 'application/json');
        String environment = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(actualWork(environment)));
    }

    global static list<ReturnShape> actualWork(string environment){
        List<Org_Pool__c> pools = [SELECT Hours__c, Quantity__c, Github_User__c, Repo__c, Branch__c,
        (select Quantity__c from Temporary_Pools__r where Start_Time__c = TODAY OR Start_Time__c = TOMORROW)
        FROM Org_Pool__c
        WHERE environment__c = :environment];

        list<ReturnShape> output = new list<ReturnShape>();

        for (Org_Pool__c pool:pools){
            system.debug(pool);
            ReturnShape item = new ReturnShape();
            item.user = pool.Github_User__c;
            item.repo = pool.Repo__c;
            item.branch = pool.Branch__c;
            item.lifeHours = integer.valueOf(pool.Hours__c);
            integer quantity = integer.valueOf(pool.Quantity__c);
            // item.quantity =

            for (Temporary_Pool__c temp:pool.Temporary_Pools__r){
                system.debug(temp);
                quantity = quantity + integer.valueOf(temp.Quantity__c);
                system.debug('quantity is ' + quantity);
            }

            item.quantity = quantity;
            output.add(item);
        }

        return output;
    }

    global class ReturnShape {
        string user {get;set;}
        string repo {get;set;}
        string branch {get;set;}
        integer quantity {get;set;}
        integer lifeHours {get;set;}
    }

}

// testing scripts
// system.debug(poolsRestApi.actualWork('Production'));