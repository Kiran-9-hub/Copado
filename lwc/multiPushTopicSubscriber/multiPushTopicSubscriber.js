import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { subscribe, onError } from 'lightning/empApi';

export default class MultiPushTopicSubscriber extends LightningElement {
    channels = [
        '/topic/AccountChanges',
        '/topic/ContactChanges',
        '/topic/OpportunityChanges',
         '/topic/BikeChanges'
    ];
    subscriptions = [];

    connectedCallback() {
        this.channels.forEach(channel => {
            subscribe(channel, -1, message => this.handleMessage(channel, message)).then(response => {
                console.log(`✅ Subscribed to ${channel}`);
                this.subscriptions.push(response);
            });
        });

        onError(error => {
            console.error('❌ PushTopic Error:', JSON.stringify(error));
        });
    }

    handleMessage(channel, message) {
        const sObj = message.data.sobject;
        const entity = channel.split('/')[2].replace('Changes', '');

        this.dispatchEvent(
            new ShowToastEvent({
                title: `🔄 ${entity} Updated`,
                message: `ID: ${sObj.Id}, Changes detected.`,
                variant: 'info'
                
            })
            
        );
    }
    
}