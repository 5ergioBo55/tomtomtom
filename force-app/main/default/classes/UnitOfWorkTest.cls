@isTest
public with sharing class UnitOfWorkTest {
    @isTest public static void challengeComplete() {

        // creat uow
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SobjectType[]{
                Account.SObjectType,
                Contact.SObjectType,
                Note.SObjectType
            }

        );

        // insert 100 accounts
        for(Integer i = 0; i<100; i++){
            Account acc = new Account(
                Name = 'Test Account '+ i
            );

            // add acc to uow registerNew
            uow.registerNew(acc);

            // insert 5 accounts + 5 notes
            for(Integer j=0; j<5; j++){
                Contact contactOfAccount = new Contact(
                    FirstName = 'ContactFirstName'+i,
                    LastName = 'ContactLastName'+i
                );
                // add c to uow registernew
                uow.registerNew(contactOfAccount, Contact.AccountId, acc);

                Note noteOfAccount = new Note(
                    Title = 'Note'+i,
                    Body = 'Test Body '+i
                );
                // add note to uow registernew
                uow.registerNew(noteOfAccount, Note.ParentId, acc);
            }
        }

        Test.startTest();
        uow.commitWork();
        Test.stopTest();
        
        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());

    }
}
