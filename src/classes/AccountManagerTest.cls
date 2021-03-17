/**
 * Created by a000 on 17.03.2021.
 */

@isTest
private with sharing class AccountManagerTest {

    @isTest static void testGet() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
                'https://yourInstance.salesforce.com/services/apexrest/Accounts/'
                        + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisCase = AccountManager.getAccount();
        System.assert(thisCase != null);
        System.assertEquals('some', thisCase.name);
    }
    static Id createTestRecord() {
        Account accountTest = new Account(
                Name = 'some'
                );
        insert accountTest;
        Contact contactTest = new Contact(LastName = 'test Contact',
                AccountId = accountTest.Id);
        insert contactTest;
        return accountTest.Id;
    }
}