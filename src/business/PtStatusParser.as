package business
{
	import  vos.PtStatusVO;
	
	public class PtStatusParser
	{
		
		/*-.........................................Methods..........................................*/
		
		public function loadStatusFromXML(ptstatus:XML):Array 
		{
			var statusList:Array = new Array();
				
			for each( var thisStatus:XML in ptstatus..status ) 
			{
				var status:PtStatusVO= new PtStatusVO();
				//status.lastname = "undefined";
				status.id= thisStatus.id;	
				status.ptid= thisStatus.ptid;	
				status.lastname = thisStatus.lastname;								
				status.surgery = thisStatus.surgery;		
				status.psalast = thisStatus.psalast;		
				status.bxlast = thisStatus.bxlast;		
				status.fulast = thisStatus.fulast;									

				//status.surgery = new Date(Date.parse(thisStatus.surgery));		
				//status.psalast = new Date(Date.parse(thisStatus.psalast));		
				//status.bxlast = new Date(Date.parse(thisStatus.bxlast));		
				//status.fulast = new Date(Date.parse(thisStatus.fulast));									
				
				// add recs to array
				statusList.push(status);
				
				// Convert to array collection??								
			}			
			return statusList;
		}

	}
}