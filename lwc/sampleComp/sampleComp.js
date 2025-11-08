import { LightningElement,api,track,wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class SampleComp extends LightningElement {

 @wire(getAccounts) accounts;

}