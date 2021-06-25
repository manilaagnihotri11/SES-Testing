public class AccountPlanController{
    public class DataSet{      
               
        @AuraEnabled
        public Set<String> Name {get;set;}
        @AuraEnabled
        public List<Integer>  Close {get;set;}
        @AuraEnabled
        public List<Integer>  Open {get;set;}
    }
    @AuraEnabled
    public static DataSet getAllTasksByStatus(){
        Set<String> nameSet = new Set<String>();
        List<Integer> Close = new List<Integer>();
        List<Integer> Open = new List<Integer>();
        List<AggregateResult> result =  [Select Count(Id) cnt, Status,Owner.Name from Task where WhoId='0032w000008Ixs4' group by Owner.Name ,Status ];
        
        DataSet dataSet = new DataSet();
        for(AggregateResult ar:result){
            if(nameSet.size()==0 || !nameSet.contains((String)ar.get('Name')))
            {
                nameSet.add((String)ar.get('Name'));
                if((String)ar.get('Status')=='Completed'){
                    Close.add((Integer)ar.get('cnt'));
                }
                else{
                    Open.add((Integer)ar.get('cnt'));
                }
                
            }
            else{
                if((String)ar.get('Status')=='Completed'){
                    Close.add((Integer)ar.get('cnt'));
                }
                else{
                    Open.add((Integer)ar.get('cnt'));
                }
            }
            String status =  (String)ar.get('Status') ;
            Integer total =(Integer)ar.get('cnt'); 
            dataSet.Name=nameSet;
             dataSet.Close=Close;
             dataSet.Open=Open;
            
        }
        System.debug('dataSet'+dataSet);
        return dataSet ; 
    }
}