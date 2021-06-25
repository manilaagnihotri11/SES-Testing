public with sharing class DynamicRowsController {
     @AuraEnabled
    public static void saveaccs(List<Account> inprec){
        system.debug('inprecinprec ' + inprec);
        List<Account> acclst = new List<Account>();
        if(inprec.size()>0 && inprec != null){
       for(Account rc : inprec)
        { 
          Account AccountRec= new Account(); 
            AccountRec.Name = rc.Name;
              AccountRec.Industry = rc.Industry;
             acclst.add(AccountRec);
            
        }
            insert acclst;
        }
    }

}