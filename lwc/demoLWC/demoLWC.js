import { LightningElement, track } from 'lwc';
import searchCounts from '@salesforce/apex/accountSearch.searchCounts';
import { NavigationMixin } from 'lightning/navigation';

export default class DemoLWC extends NavigationMixin(LightningElement) {
    @track searchKey = '';
    @track accountWithContactList = [];

    handleKeyChange(event) {
        this.searchKey = event.target.value;

        if (this.searchKey !== '') {
            searchCounts({ searchKey: this.searchKey })
                .then((result) => {
                    this.accountWithContactList = result;
                })
                .catch((error) => {
                    this.accountWithContactList = [];
                    console.error('Error fetching data:', error);
                });
        } else {
            this.accountWithContactList = [];
        }
    }

    handleNavigation(event) {
        const accountId = event.target.dataset.id;
    
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: accountId,
                objectApiName: 'Account',
                actionName: 'view'
            }
        });
    }
    
}