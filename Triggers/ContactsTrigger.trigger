trigger ContactsTrigger on Contact (before insert, before update, before delete,
  									after insert, after update, after delete, after undelete) {
  										
    if(Trigger.isAfter && Trigger.isInsert || Trigger.isAfter && Trigger.isUndelete) {
        ContactsTriggerHandler.handleAfterInsertAndAfterUndelete(Trigger.new);
    }
    else if(Trigger.isAfter && Trigger.isDelete) {
    	
        ContactsTriggerHandler.handleAfterDelete(Trigger.old);
    }
	else if(Trigger.isAfter && Trigger.isUpdate) {
        ContactsTriggerHandler.handleAfterUpdate(Trigger.old, Trigger.new);
    }
}