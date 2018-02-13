@isTest
public with sharing class ContactsTriggerHandlerTest {
    @isTest static void testRollUpNumberOfContactsOnParentAccount() {
            // GA: this test method is woefully inadequate.  You are not doing any asserts and you don't test any operation aside from Insert.  You need to test a lot more scenarios and validate the results
    		Contact[] contactsToInsert = TestDataFactory.createAccountsWithContacts(3, 2);
    		Test.startTest();
    		Database.SaveResult[] result = Database.insert(contactsToInsert, false);
    		Test.stopTest();
    		Set<Id> accountIds = ContactsTriggerHandler.getAccountIds(contactsToInsert);
    		for(Account act : [select Number_of_Contacts__c from Account where Id in :accountIds]){
    			//System.assertEquals(2, act.Number_of_Contacts__c); 
    		}
    }
}
