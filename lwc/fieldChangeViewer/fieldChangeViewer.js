import { LightningElement, track } from 'lwc';
import getFieldChanges from '@salesforce/apex/FieldChangeViewerController.getFieldChanges';
import getTrackedObjects from '@salesforce/apex/FieldTrackingConfigController.getTrackedObjects';

export default class FieldChangeViewer extends LightningElement {
    @track objectName = '';
    @track fieldName = '';
    @track startDate;
    @track endDate;
    @track fieldChanges = [];
    @track isEmpty = false;
    @track showModal = false;

    @track objectOptions = []; // Populated dynamically from Apex

    columns = [
        { label: 'Object', fieldName: 'Object_Name__c' },
        { label: 'Field', fieldName: 'Field_Name__c' },
        { label: 'Old Value', fieldName: 'Old_Value__c' },
        { label: 'New Value', fieldName: 'New_Value__c' },
        { label: 'Changed By', fieldName: 'ChangedByName' },
        {
            label: 'Date',
            fieldName: 'Change_Date__c',
            type: 'date',
            typeAttributes: {
                year: 'numeric',
                month: 'short',
                day: '2-digit',
                timeZone: 'UTC'
            }
        }
    ];

    connectedCallback() {
        // Load object names from existing configs
        getTrackedObjects()
            .then(result => {
                this.objectOptions = result.map(obj => ({
                    label: obj,
                    value: obj
                }));
            })
            .catch(error => {
                console.error('Error fetching object options:', error);
            });
    }

    handleObjectChange(event) {
        this.objectName = event.detail.value;
    }

    handleFieldNameChange(event) {
        this.fieldName = event.detail.value;
    }

    handleStartDateChange(event) {
        this.startDate = event.detail.value;
    }

    handleEndDateChange(event) {
        this.endDate = event.detail.value;
    }

    handleSearch() {
        getFieldChanges({
            objectName: this.objectName,
            fieldName: this.fieldName,
            startDate: this.startDate,
            endDate: this.endDate
        })
        .then(result => {
            this.fieldChanges = result.map(item => ({
                ...item,
                ChangedByName: item.Changed_By__r ? item.Changed_By__r.Name : 'Unknown'
            }));
            this.isEmpty = this.fieldChanges.length === 0;
        })
        .catch(error => {
            console.error('Error:', error);
            this.fieldChanges = [];
            this.isEmpty = true;
        });
    }

    handleAddConfig() {
        this.showModal = true;
    }

    handleCloseModal() {
        this.showModal = false;
    }

    handleConfigSaved() {
        this.showModal = false;
        // Optional: refresh tracking if needed
    }
}