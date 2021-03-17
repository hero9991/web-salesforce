/**
 * Created by a000 on 17.03.2021.
 */
@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager{
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        system.debug(accountId);
        Account objAccount = [SELECT Id,Name,(SELECT Id,Name FROM Contacts) FROM Account WHERE Id = :accountId LIMIT 1];
        return objAccount;
    }
    @HttpPost
    global static Id createAccount(String name) {
        Account acc = new Account(Name = name);
        insert acc;
        return acc.Id;
    }
    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account acc = [SELECT Id FROM Account WHERE id = :accountId LIMIT 1];
        delete acc;
    }
    @HttpPut
    global static Id upsertAccount(String name) {
        Account acc = new Account(Name = name);
        upsert acc;
        return acc.Id;
    }
    @HttpPatch
    global static Id updateAccount() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/' + 1));
        Account acc = [SELECT Name FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Name += ' updated';
        update acc;
        return acc.Id;
    }
}