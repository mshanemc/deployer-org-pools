/* eslint-disable no-console */
import { LightningElement, api, wire, track } from 'lwc';
import getWorkshopSchedule from '@salesforce/apex/WorkshopSchedule.getWorkshopSchedule';

export default class WorkshopSchedule extends LightningElement {
    @api recordId;
    @track WorkshopSchedule = [];

    // get the list of scheduled workshops for this org_pool__c only in the future
    @wire(getWorkshopSchedule, { poolId: '$recordId' })
    wiredSchedule({ error, data }) {
        if (error) {
            console.log(error);
        }
        if (data) {
            console.log(data);
            this.WorkshopSchedule = data;
        }
    }

    get hasSchedule() {
        return this.WorkshopSchedule.length > 0;
    }
}
