/**
* @File Name : AccountController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : April 24, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | April 24, 2025 |   | Initial Version
**/

public class AccountController {
	
	 @AuraEnabled
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, Industry FROM Account LIMIT 5];
    }
}