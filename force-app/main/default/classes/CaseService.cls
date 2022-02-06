public with sharing class CaseService {
    
    public static void closeCases(Set<Id> caseIds, String closedReason){
        // query for cases 
        List<Case> cases4update = new List<Case>();
        
        for(Id cID: caseIds){
            
            Case c = new Case(
                Id = cID,
                Reason = closedReason,
                Status = 'Closed'
            );

            cases4update.add(c);
        }

        try {
            update cases4update;
        } catch (Exception e) {
            throw e;
        }

    }
}