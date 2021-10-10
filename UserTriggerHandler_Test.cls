@isTest
private class UserTriggerHandler_Test
{
    @isTest
    static void testUserChangingAddress() {

        User newUser = new User();
            newUser.firstName = 'Test';
            newUser.LastName = 'User';
            newUser.Alias = 'test';
            newUser.Email = 'testuser@ccjax.com';
            newUser.UserName= 'testuser@ccjax.com';
            newUser.ProfileId = '00eE0000000WNzPIAW';
            newUser.CommunityNickname = 'testNick@ccjax.com';
            newUser.EmailEncodingKey ='ISO-8859-1';
            newUser.LanguageLocaleKey = 'en_US';
            newUser.TimeZoneSidKey ='America/Denver';
            newUser.LocaleSidKey = 'en_US';
            newUser.Street = '195 Inca Pkwy';
            newUser.City = 'Boulder';
            newUser.State = 'CO';
            newUser.PostalCode = '80303';
            newUser.Country = 'United States';
        insert newUser;

        Contact contactObj = new Contact();
            contactObj.FirstName = 'Johnny';
            contactObj.LastName = 'Football';
            contactObj.User__c = newUser.id;
            contactObj.MailingStreet = '123 Main St';
            contactObj.MailingCity = 'Boulder';
            contactObj.MailingState = 'CO';
            contactObj.MailingPostalCode = '80303';
            contactObj.MailingCountry = 'United States';
        insert contactObj;

        Test.StartTest();
            newUser.Street = '199 Inca Pkwy';
            update newUser;
        Test.StopTest();

        Contact conObj = [SELECT Id,MailingStreet,User__c FROM Contact where User__c = :newUser.Id LIMIT 1];
        system.assertEquals('199 Inca Pkwy', conObj.MailingStreet);
        );
    }
}