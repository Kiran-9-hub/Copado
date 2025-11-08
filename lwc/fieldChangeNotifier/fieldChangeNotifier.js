import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { subscribe, onError } from 'lightning/empApi';

export default class FieldChangeSubscriber extends LightningElement {
    channelName = '/event/Field_Change_Notification__e';
    subscription = {};

    connectedCallback() {
        console.log('🚀 LWC loaded and connectedCallback called');
        this.handleSubscribe();
        this.registerErrorListener();
    }

    handleSubscribe() {
        const messageCallback = (response) => {
            try {
                const payload = response.data.payload;

                console.log('📬 Event Received:', JSON.stringify(payload));
                console.log('➡️ Field:', payload.Field_Name__c);
                console.log('➡️ Old Value:', payload.Old_Value__c);
                console.log('➡️ New Value:', payload.New_Value__c);

                // Optional: Filter by object if needed
                // if (payload.Object_Name__c !== 'Account') return;

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: `🔔 Field Changed: ${payload.Field_Name__c}`,
                        message: `Old: ${payload.Old_Value__c || 'null'} → New: ${payload.New_Value__c || 'null'}`,
                        variant: 'info'
                    })
                );
            } catch (e) {
                console.error('❌ Error processing platform event message:', e);
            }
        };

        subscribe(this.channelName, -1, messageCallback).then((response) => {
            console.log('✅ Subscribed to channel:', response.channel);
            this.subscription = response;
        }).catch((err) => {
            console.error('❌ Subscription failed:', JSON.stringify(err));
        });
    }

    registerErrorListener() {
        onError(error => {
            console.error('⚠️ Error from EMP API:', JSON.stringify(error));
        });
    }
}