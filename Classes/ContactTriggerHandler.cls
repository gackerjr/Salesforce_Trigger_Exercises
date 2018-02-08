public with sharing class ContactTriggerHandler {
	private boolean m_isExecuting = false;
	private integer BatchSize = 0;
	
	public ContactTriggerHandler(boolean isExecuting, integer size){
		m_isExecuting = isExecuting;
		BatchSize = size;
	}
		
	public void OnBeforeInsert(Contact[] newContacts){
		
	}
	
	public void OnAfterInsert(Contact[] newContacts){
        
        system.debug('newContacts => ' + newContacts);
        
        Set<Id> resultIds = (new Map<Id, Contact>(newContacts)).keySet();
        system.debug('resultIds => ' + resultIds);
        
        /*List<Account> accounts = [select Id, Name from Account Id IN :resultIds];
		system.debug('accounts => ' + accounts);*/
	}
	
	@future public static void OnAfterInsertAsync(Set<ID> newContactIDs){
		//Example usage
		//
		//List<Contact> newContacts = [select Id, Name from Contact where Id IN :newContactIDs];
	}
	
	public void OnBeforeUpdate(Contact[] oldContacts, Contact[] updatedContacts, Map<ID, Contact> accountMap){
		}
	
	public void OnAfterUpdate(Contact[] oldContacts, Contact[] updatedContacts, Map<ID, Contact> accountMap){
		
	}
	
	@future public static void OnAfterUpdateAsync(Set<ID> updatedContactIDs){
		List<Contact> updatedContacts = [select Id, Name from Contact where Id IN :updatedContactIDs];
	}
	
	public void OnBeforeDelete(Contact[] accountsToDelete, Map<ID, Contact> accountMap){
		
	}
	
	public void OnAfterDelete(Contact[] deletedContacts, Map<ID, Contact> accountMap){
		
	}
	
	@future public static void OnAfterDeleteAsync(Set<ID> deletedContactIDs){
		
	}
	
	public void OnUndelete(Contact[] restoredContacts){
		
	}
	
	public boolean IsTriggerContext{
		get{ return m_isExecuting;}
	}
	
	public boolean IsVisualforcePageContext{
		get{ return !IsTriggerContext;}
	}
	
	public boolean IsWebServiceContext{
		get{ return !IsTriggerContext;}
	}
	
	public boolean IsExecuteAnonymousContext{
		get{ return !IsTriggerContext;}
	}
}