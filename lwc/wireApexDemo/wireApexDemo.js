import { LightningElement,api, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class WireApexDemo extends LightningElement {

    @api recordId;

    @wire(getContacts, { accId: '$recordId' }) // wire the getContacts method from the Apex class
    contacts; // store the result in the contacts property
    // contacts is an object that contains the data returned from the Apex method
}