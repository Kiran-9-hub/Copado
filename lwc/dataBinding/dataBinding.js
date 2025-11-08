import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {
    firstName = '';
    lastName = '';

    handleClick() {
        const inputFields = this.template.querySelectorAll('lightning-input');

        inputFields.forEach((element) => {
            if (element.name === 'fName') {
                this.firstName = element.value;
            } else if (element.name === 'lName') {
                this.lastName = element.value;
            }
        });
    }
}