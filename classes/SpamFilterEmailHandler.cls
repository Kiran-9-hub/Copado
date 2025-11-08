global class SpamFilterEmailHandler implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

        try {
            String subject = email.subject != null ? email.subject.toLowerCase() : '';
            String body = email.plainTextBody != null ? email.plainTextBody.toLowerCase() : '';
            System.debug('Email received: ' + subject);

            List<String> spamKeywords = new List<String>{'buy now', 'free money', 'click here', 'win prize', 'viagra'};
            Boolean isSpam = false;

            for (String keyword : spamKeywords) {
                if (subject.contains(keyword) || body.contains(keyword)) {
                    isSpam = true;
                    break;
                }
            }

            Case c = new Case(
                Subject = email.subject != null ? email.subject : 'No Subject',
                Description = email.plainTextBody != null ? email.plainTextBody : '',
                Origin = 'Email',
                Status = 'New',
                Is_Spam__c = isSpam
            );

            insert c;

            System.debug('Case created with Id: ' + c.Id + ', Is Spam: ' + isSpam);
            result.success = true;

        } catch (DmlException dmlEx) {
            System.debug('DML Exception inserting Case: ' + dmlEx.getMessage());
            for (Integer i = 0; i < dmlEx.getNumDml(); i++) {
                System.debug('DML Error: ' + dmlEx.getDmlMessage(i));
            }
            result.success = false;
        } catch (Exception e) {
            System.debug('General Exception: ' + e.getMessage());
            result.success = false;
        }

        return result;
    }
}