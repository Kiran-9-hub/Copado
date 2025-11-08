import { LightningElement } from 'lwc';

export default class LifecycleChildComponent extends LightningElement {
constructor(){
    super();
    console.log('Child Constructor called');
}

connectedCallback(){
    console.log('Child connectedCallback called');

}
renderedCallback(){
    console.log('Child renderedCallback called');

}
disconnectedCallback(){
    console.log('Child disconnectedCallback called');
}

}