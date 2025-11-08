import { LightningElement, wire } from 'lwc';
import { subscribe,MessageContext } from 'lightning/messageService';
import ChildtoGrandparent from '@salesforce/messageChannel/ChildToGrandparent__c';


export default class SubscriberGrandparent extends LightningElement {
    receivedata;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
       subscribe(this.messageContext, ChildtoGrandparent, (message) => {
            this.receivedata = message.data;
        });
    }
}