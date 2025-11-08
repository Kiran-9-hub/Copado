trigger HandleTelemetryEvent on Vehicle_Telemetry_Event__e (after insert) {

    
    for(Vehicle_Telemetry_Event__e telemEvent : Trigger.New){
        
        
        List<Vehicle__c> vehicles = [SELECT Id, FuelLevel__c, Mileage__c FROM Vehicle__c WHERE VIN__c = :telemEvent.VehicleVIN__c];
        
        
        for (Vehicle__c vehicle : vehicles) {
            vehicle.FuelLevel__c = telemEvent.FuelLevel__c;
            vehicle.Mileage__c = telemEvent.Mileage__c;
            
            
            if(telemEvent.FuelLevel__c < 15){
                
                Service_Appointment__c sa = new Service_Appointment__c(
                    Vehicle__c = vehicle.Id,
                    Date__c = System.today().addDays(1),
                    Dealer__c = 'Default Dealer',
                    Status__c = 'Scheduled'
                );
                insert sa;
            }
        }
        
        
        update vehicles;
    }
}