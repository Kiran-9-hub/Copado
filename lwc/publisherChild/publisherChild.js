import { LightningElement, wire } from 'lwc';
import { publish,MessageContext } from 'lightning/messageService';
import ChildtoGrandparent from '@salesforce/messageChannel/ChildToGrandparent__c';

export default class PublisherChild extends LightningElement {
    
    @wire(MessageContext)
    messageContext;

    handleClick() {
        const message = {
            data: 'Hello from Child Component!'
        };
        publish(this.messageContext, ChildtoGrandparent, message);
    }
}