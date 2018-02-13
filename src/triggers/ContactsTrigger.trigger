// GA: why are you capturing before events when you only use after?
trigger ContactsTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete)
    // you shouldn't have to check Trigger.isAfter so many times.  Check it once and then nest the other IF statements inside it.
    if(Trigger.isAfter && Trigger.isInsert || Trigger.isAfter && Trigger.isUndelete) {
    		System.debug('---> Contact -- After -- Insert/Undelete');
        ContactsTriggerHandler.handleAfterInsertAndAfterUndelete(Trigger.new);
    }
    else if(Trigger.isAfter && Trigger.isDelete) {
    		System.debug('---> Contact -- After -- Delete');
        ContactsTriggerHandler.handleAfterDelete(Trigger.old);
    }
	else if(Trigger.isAfter && Trigger.isUpdate) {
		System.debug('---> Contact -- After -- Update');
        ContactsTriggerHandler.handleAfterUpdate(Trigger.old, Trigger.new);
    }
}
