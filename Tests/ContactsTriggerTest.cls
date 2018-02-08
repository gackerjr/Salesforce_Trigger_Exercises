@isTest
public with sharing class ContactsTriggerTest {
	public static Integer numberOfContacts = 1;
	public static Integer numberOfAccounts = 1;
    @isTest static void testHandleAfterInsert() {
    		System.debug('=== Testing After Insert === ');
        Contact[] contacts = TestDataFactory.createContactsWithAccount(numberOfContacts,numberOfAccounts);
        
        Test.startTest();
        System.debug(' Insert Contact => '+contacts);
        Database.SaveResult[] result = Database.insert(contacts, false);
        Test.stopTest();
        
		for (Database.SaveResult sr : result) {
			System.debug('System.assert => '+ sr);
			System.assert(sr.isSuccess());
		}
    }
    
    @isTest static void testHandlAfterUndelete() {
    		System.debug('=== Testing After Undelete === ');
        Contact[] contacts = TestDataFactory.createContactsWithAccount(numberOfContacts,numberOfAccounts);
        System.debug(' Insert Contact => '+contacts);
        insert(contacts);
        System.debug(' Delete Contact => '+contacts);
        delete(contacts);
        
        Test.startTest();
        System.debug(' Undelete Contact => '+ contacts);
        Database.UndeleteResult[] result = Database.undelete(contacts, false);
        Test.stopTest();
        
		for (Database.UndeleteResult udr : result) {
			System.debug(' System.assert => '+ udr);
			System.assert(udr.isSuccess());	
		}
    }
    
    @isTest static void testHandAfterDelete() {
    		System.debug('=== Testing After Delete === ');
        Contact[] contacts = TestDataFactory.createContactsWithAccount(numberOfContacts,numberOfAccounts);
        System.debug(' Insert Contact => '+contacts);
        insert(contacts);
        
        Test.startTest();
        System.debug(' Delete Contact => '+ contacts);
        Database.DeleteResult[] result = Database.delete(contacts, false);
        Test.stopTest();
        
		for (Database.DeleteResult dr : result) {
			System.debug(' System.assert => '+ dr);
			System.assert(dr.isSuccess());	
		}
    }
    
    @isTest static void testAfterUpdate() {
    		List<Contact> contactsToUpdate = new List<Contact>();
    		System.debug('=== Testing After Update === ');
    		
        Contact[] contactsRemovingAccount = TestDataFactory.createContactsWithAccount(numberOfContacts,numberOfAccounts);
        Contact[] contactsWithoutAccount = TestDataFactory.createContacts(numberOfContacts);
        
        insert(contactsRemovingAccount);
        for(Contact ct : contactsRemovingAccount){
        		ct.AccountId = null;
        		contactsToUpdate.add(ct);
        }
        
        insert(contactsWithoutAccount);
        Account[] accountsToAddToContacts = TestDataFactory.createAccounts(numberOfAccounts);
        Contact[] contactsAddingAccount = TestDataFactory.addAccountToContacts(contactsWithoutAccount, accountsToAddToContacts);
        for(Contact ct : contactsAddingAccount){
        		contactsToUpdate.add(ct);
        }
        
        Test.startTest();
        System.debug(' Update Contacts => '+ contactsToUpdate);
        Database.SaveResult[] result = Database.update(contactsToUpdate, false);
        Test.stopTest();
		for (Database.SaveResult dr : result) {
			System.debug(' System.assert => '+ dr);
			System.assert(dr.isSuccess());	
		}
    }
    
    
}