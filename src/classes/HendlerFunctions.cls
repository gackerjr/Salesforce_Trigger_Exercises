public class HendlerFunctions {
    public static void rollUpNumberOfContactsOnParentAccount(Set<Id> accountIds){
        
        if(accountIds.size() > 0){
        		List<Account> accountsToUpdate = new List<Account>();
        		
        		for(Id acct : accountIds){
        			AggregateResult[] countedContacts = [Select count(AccountId) amountOfContacts 
        												from Contact where AccountId = :acct];
        			Decimal amountOfContacts = (Decimal) countedContacts[0].get('amountOfContacts');
        			Account accountToUpdate = new Account(Id=acct);
        			accountToUpdate.Number_of_Contacts__c = amountOfContacts;
        			accountsToUpdate.add(accountToUpdate);
        		}
    			update(accountsToUpdate);
        }
    }  
    public static Set<Id> getAccountIds(List<Contact> contacts){
    		Set<Id> accountIds = new Set<Id>();
        for(Contact c : contacts){
            if(c.AccountId != null){
              Id accId = c.AccountId;
              accountIds.add(accId);  
            }
        }
        return accountIds;
    }
    public static Set<Id> getAccountsToUpdate(List<Contact>oldContacts, List<Contact>newContacts){
		
		List<Contact> contactsToGetAccountsId = new List<Contact>();
		
		for(Integer i=0; i<newContacts.size(); i++){
			
			if(newContacts[i].get('AccountId') != oldContacts[i].get('AccountId') && newContacts[i].get('AccountId') != null){
				contactsToGetAccountsId.add(newContacts[i]);
			}else if(newContacts[i].get('AccountId') != oldContacts[i].get('AccountId') && newContacts[i].get('AccountId') == null){
				contactsToGetAccountsId.add(oldContacts[i]);
			}
		}
		
		Set<Id> accountIdsToUpdate = getAccountIds(contactsToGetAccountsId);
		
		return accountIdsToUpdate;
    }
}