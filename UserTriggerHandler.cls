public with sharing class UserTriggerHandler {

    public static void onAfterUpdate(Map<Id,User> newMap, Map<Id,User> oldMap)
	{
        //Collect only the Users that have had the address change
        List<User> changedAddressUsers = new List<User>();
		for(User newUser : newMap.values())
		{
            User oldUser = oldMap.get(newUser.id);
            //Check if any of the address has changed.
            if(newUser.Street != oldUser.Street || 
               newUser.City != oldUser.City ||
               newUser.State != oldUser.State ||
               newUser.Country != oldUser.Country){
                  changedAddressUsers.add(newUser);
            }
		}

        updateContactsMailingAddress(changedAddressUsers, newMap);
	}

    //This method will update all the contacts associated with the User.
    private static void updateContactsMailingAddress(List<User> changedUsers, Map<Id,User> newMap)
	{
        //This collection is used to bulkify the update.
        List<Contact> allUserContacts = [SELECT id,MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry,User__c FROM Contact WHERE User__c in :changedUsers];
        for(Contact aContact : allUserContacts){
            User aUser = newMap.get(aContact.User__c);
            aContact.MailingStreet = aUser.Street;
            aContact.MailingCity = aUser.City;
            aContact.MailingState = aUser.State;
            aContact.MailingPostalCode = aUser.PostalCode;
            aContact.MailingCountry = aUser.Country;
        }
        if(!allUserContacts.isEmpty()){
            update allUserContacts;
        }
	}
}
