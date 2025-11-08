import { LightningElement } from 'lwc';

export default class LifecycleParentHook extends LightningElement {
    constructor(){
        super();
        console.log('Parent Constructor called');
    }

    connectedCallback(){
        console.log('Parent connectedCallback called');

    }
    renderedCallback(){
        console.log('Parent renderedCallback called');

    }
    errorCallback(){
        console.log('Parent errorCallback called');
    }
}