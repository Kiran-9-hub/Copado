import { LightningElement, api } from 'lwc';
import cloneAccountRecord from '@salesforce/apex/RecordClone.cloneAccountRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class RecordCloner extends NavigationMixin(LightningElement) {
    @api recordId;

    handleClone() {
        cloneAccountRecord({ recordId: this.recordId })
            .then((newRecordId) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record cloned successfully',
                        variant: 'success',
                    })
                );
                
                // Navigate to the new record
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: newRecordId,
                        objectApiName: 'Account', // Change if using other object
                        actionName: 'view'
                    }
                });
            })
           .catch((error) => {
    console.error('Clone Error:', JSON.stringify(error)); // 👈 Add this line
    this.dispatchEvent(
        new ShowToastEvent({
            title: 'Error cloning record',
            message: error.body.message || 'Unknown error',
            variant: 'error',
        })
    );
});

    }
}