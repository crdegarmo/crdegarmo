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
            UserTriggerHandler.onAfterUpdate(trigger.newMap, trigger.oldMap);
        }       
    }
}