import { LightningElement } from 'lwc';

export default class Child extends LightningElement {
    handleClick() {
        const message = 'Hello from Child Component';
        const event = new CustomEvent('clickchild', {
            detail: message,
            bubbles: true, // Allow the event to bubble up to parent components
            composed: true // Allow the event to cross the shadow DOM boundary
        });
        this.dispatchEvent(event);
    }
}