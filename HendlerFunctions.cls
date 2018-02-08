public class HendlerFunctions {
    public static void rollUpNumberOfContactsOnParentAccount(Set<Id> accountIds){
    		System.debug('====================================================');
    		System.debug('Start RollUp == Contacts => ' + accountIds);
        
        if(accountIds.size() > 0){
        		List<Account> accountsToUpdate = new List<Account>();
        		for(Id acct : accountIds){
        			System.debug('====================================================');
        			System.debug('Account ID Number-' + acct);
        			AggregateResult[] countedContacts = [Select count(AccountId) amountOfContacts 
        												from Contact where AccountId = :acct];
				System.debug('Aggregate Result Number of Contact => ' + countedContacts);
        			Decimal amountOfContacts = (Decimal) countedContacts[0].get('amountOfContacts');
        			System.debug('Decimal number of Contacts => ' + amountOfContacts);
        			Account accountToUpdate = new Account(Id=acct);
        			System.debug('Get account to Update => ' + accountToUpdate);
        			accountToUpdate.Number_of_Contacts__c = amountOfContacts;
        			System.debug('Account with new number of contacts => ' + accountToUpdate);
        			accountsToUpdate.add(accountToUpdate);
        			System.debug('Added to Array of Accounts => ' + accountToUpdate);
        			System.debug('====================================================');
        		}
        		System.debug('Updating these accounts => ' + accountsToUpdate);
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