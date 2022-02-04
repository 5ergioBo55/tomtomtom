public with sharing class CaseService {
    
    public static void closeCases(Set<Id> caseIds, String closedReason){
        // query for cases 
        List<Case> cases = [
            SELECT Id, Reason
            FROM Case
            WHERE Id IN :caseIds
        ];
        for(Case c: cases){
            c.Reason = closedReason;
        }

        try {
            update cases;
        } catch (Exception e) {
            throw e;
        }

    }
}
