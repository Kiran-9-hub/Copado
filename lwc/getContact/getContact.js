import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/contactclass.getContacts';

export default class GetContact extends LightningElement {
    @api recordId;
    contacts;
    error;

    @wire(getContacts)
    wiredContacts({ data, error }) {
        if (data) {
            this.contacts = data;
        } else if (error) {
            this.error = error;
        }
    }
}