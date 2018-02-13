// GA: Hendler is not an English work.  Might be nitpicky, but proper spelling and grammar goes a long way to readability.  Also, this is specific to Account/Contact rollup, so why is the name generic?
public class HendlerFunctions {
    public static void rollUpNumberOfContactsOnParentAccount(Set<Id> accountIds){
        
        if(accountIds.size() > 0){
        		List<Account> accountsToUpdate = new List<Account>();
        		
        		for(Id acct : accountIds){
				// GA: Query in for loop should NEVER be done in Salesforce.  You will violate governor limits
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
			// GA: This condition is not really fully thought out.  Basically, if they account ID changes, we need to recalculate both the old and the new (one if statement, two entries into the set).  Ignore any nulls before adding to the set.  That should be the logic.
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
