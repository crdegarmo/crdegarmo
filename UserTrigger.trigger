trigger UserTrigger on User (before insert, after insert, before update, after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            
        }
        else if(trigger.isUpdate){
           
        }
    }
    else if(trigger.isAfter){
        if(trigger.isInsert){

        }
        else if(trigger.isUpdate){
            // I usually choose a more generic method in the handler class so that it is easy to add additional code in the handler without
            // updating the Trigger
            UserTriggerHandler.onAfterUpdate(trigger.newMap, trigger.oldMap);
        }       
    }
}
