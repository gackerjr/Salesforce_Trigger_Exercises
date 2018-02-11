@isTest
public class TestDataFactory {
	public static List<Contact> createContactsWithAccount(Integer numAccts, Integer numConts) {    
		List<Account> accounts = createAccounts(numAccts);
        List<Contact> contacts = createContacts(numConts);
        addAccountToContacts(contacts, accounts);
        return contacts;
	}
	
	public static List<Account> createAccounts(Integer numAccts){
		List<Account> createdAccounts = new List<Account>();
		for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            createdAccounts.add(a);
        }
		return createdAccounts;
	}
	
	public static List<Contact> createContacts(Integer numConts){
		List<Contact> contacts = new List<Contact>();
    		for(Integer k=0; k<numConts; k++){
    			contacts.add(new Contact(lastName='TestContact '+k));
    		}
        return contacts;
	}
	
	
	public static List<Contact> addAccountToContacts(List<Contact>contacts, List<Account>accounts){
		insert(accounts);
		for(Integer j=0; j<accounts.size(); j++){
        		Account acct = accounts[j];
        		for(Integer k=0; k<contacts.size(); k++){
        			contacts[k].AccountId = acct.Id;
        		}
        }
        return contacts;
	}
}