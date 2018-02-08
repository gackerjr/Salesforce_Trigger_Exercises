public class ContactsTriggerHandler {
    public static void handleAfterInsertAndAfterUndelete(List<Contact> contacts){
    		Set<Id> accountIds = HendlerFunctions.getAccountIds(contacts);
        System.debug('Account IDs => ' + accountIds);
        HendlerFunctions.rollUpNumberOfContactsOnParentAccount(accountIds);
    }
    public static void handleAfterDelete(List<Contact> contacts){
    		Set<Id> accountIds = HendlerFunctions.getAccountIds(contacts);
        System.debug('Account IDs => ' + accountIds);
    		HendlerFunctions.rollUpNumberOfContactsOnParentAccount(accountIds);
    }
    public static void handleAfterUpdate(List<Contact> oldContacts, List<Contact> newContacts){
    		Set<Id> accountIds = HendlerFunctions.getAccountsToUpdate(oldContacts, newContacts);
        System.debug('Account IDs => ' + accountIds);
    		HendlerFunctions.rollUpNumberOfContactsOnParentAccount(accountIds);
    }
}