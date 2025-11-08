import { LightningElement, track } from 'lwc';
import saveTrackingConfig from '@salesforce/apex/FieldTrackingConfigController.saveTrackingConfig';
import getExistingConfigs from '@salesforce/apex/FieldTrackingConfigController.getExistingConfigs';

export default class FieldTrackingForm extends LightningElement {
    @track objectName = '';
    @track fieldName = '';
    @track isCritical = false;
    @track errorMessage = '';
    @track success = false;
    @track existingConfigs = [];
    @track isDuplicate = false;

    columns = [
        { label: 'Object Name', fieldName: 'Object_Name__c' },
        { label: 'Field Name', fieldName: 'Field_Name__c' },
        { label: 'Is Critical', fieldName: 'Is_Critical__c', type: 'boolean' }
    ];

    connectedCallback() {
        this.loadExistingConfigs();
    }

    loadExistingConfigs() {
        getExistingConfigs()
            .then(result => {
                this.existingConfigs = result;
                this.checkDuplicate(); // check with latest list
            })
            .catch(error => {
                console.error('Error loading configs:', error);
            });
    }

    handleObjectChange(event) {
        this.objectName = event.detail.value;
        this.checkDuplicate();
    }

    handleFieldChange(event) {
        this.fieldName = event.detail.value;
        this.checkDuplicate();
    }

    handleCriticalChange(event) {
        this.isCritical = event.detail.checked;
    }

    checkDuplicate() {
        this.isDuplicate = this.existingConfigs.some(config =>
            config.Object_Name__c?.toLowerCase() === this.objectName?.toLowerCase() &&
            config.Field_Name__c?.toLowerCase() === this.fieldName?.toLowerCase()
        );
    }
 
    handleSave() {
    this.errorMessage = '';
    this.success = false;

    // if (this.isDuplicate) {
    //     this.errorMessage = 'This configuration already exists.';
    //     return;
    // }

    saveTrackingConfig({
        objectName: this.objectName,
        fieldName: this.fieldName,
        isCritical: this.isCritical
    })
        .then(() => {
            this.success = true;
            this.errorMessage = '';

            // Add directly to existingConfigs
            const newConfig = {
                //Id: Math.random().toString(36).substr(2, 9), // fake id for LWC key
                Object_Name__c: this.objectName,
                Field_Name__c: this.fieldName,
                Is_Critical__c: this.isCritical
            };

            
            this.existingConfigs = [...this.existingConfigs, newConfig];

            // Reset form fields
            this.objectName = '';
            this.fieldName = '';
            this.isCritical = false;
            this.isDuplicate = false;
        })
        .catch(error => {
            this.errorMessage = error?.body?.message || 'Error saving configuration.';
            this.success = false;
        });
}

}