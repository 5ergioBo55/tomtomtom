@RestResource(urlMapping='/case/*/close')

global with sharing class CaseCloseResource {
    @HttpPost
    global static void closeReason(String reason){
        // parse context
        RestRequest req = RestContext.request;

        String[] uriParts = req.requestURI.split('/');

        Id caseId = uriParts[2];

        // call service
        CaseService.closeCases(new Set<Id>{caseId}, reason);
    }
}
