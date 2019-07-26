import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import NAME from '@salesforce/schema/Org_Pool__c.Name';
import DESCRIPTION from '@salesforce/schema/Org_Pool__c.Description__c';

const FIELDS = [NAME, DESCRIPTION];

export default class WorkshopDisplay extends LightningElement {
    @api recordId;

    // get the scheduled workshop description field
    @wire(getRecord, {
        recordId: '$recordId',
        fields: FIELDS
    })
    workshop;
}
