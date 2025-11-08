import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ['Account.Name', 'Account.Phone'];

export default class RecordWireExample extends LightningElement {
    @api recordId; 

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    account;
}