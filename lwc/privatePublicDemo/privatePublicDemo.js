import { api, LightningElement } from 'lwc';

export default class PrivatePublicDemo extends LightningElement {

    message = 'Public Property';
   

    @api recordId;

}