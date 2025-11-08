import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/refreshApexclass.getAccounts';
import { refreshApex } from '@salesforce/apex';
export default class RefreshApex extends LightningElement {

    accounts;
    wiredAcccountResult;


     @wire(getAccounts)
     
     wiredAccounts(result){
        this.wiredAccountResult = result;
        if (result.data) {
            this.accounts = result.data;
        }
     }

    handleRefresh() {
        refreshApex(this.wiredAccountResult);
    }
    
}