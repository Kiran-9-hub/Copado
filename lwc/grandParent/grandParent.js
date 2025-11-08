import { LightningElement } from 'lwc';

export default class GrandParent extends LightningElement {
    message = '';
    handleChildMessage(event) {
        this.message = event.detail;
    }
}