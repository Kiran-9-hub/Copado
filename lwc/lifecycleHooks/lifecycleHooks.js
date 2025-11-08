import { LightningElement } from 'lwc';

export default class LifecycleHooks extends LightningElement {


constructor(){
    super();
    console.log('constructor called');
}

connectedCallback(){
    console.log('connectedCallback called');

}

renderedCallback(){
    console.log('renderedCallback called');

}
disconnectedCallback(){
    console.log('disconnectedCallback called');

}

}