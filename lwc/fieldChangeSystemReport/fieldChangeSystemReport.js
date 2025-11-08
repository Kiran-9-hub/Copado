import { LightningElement, track } from 'lwc';

export default class FieldChangeSystemReport extends LightningElement {
    @track trackedFields = [
        { id: 1, objectName: 'Account', fieldName: 'Name', isCritical: true },
        { id: 2, objectName: 'Contact', fieldName: 'FirstName', isCritical: true },
        { id: 3, objectName: 'Opportunity', fieldName: 'Name', isCritical: true },
        { id: 4, objectName: 'Bike__c', fieldName: 'Bike_Name__c', isCritical: true },
    ];
}