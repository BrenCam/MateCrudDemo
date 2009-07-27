package business
{
	import vos.PatientPSAVO;
	
	public class PtPSAParser
	{
		
		/*-.........................................Methods..........................................*/
		
		public function loadPSAFromXML(patientPSA:XML):Array 
		{
			var PSAList:Array = new Array();

			//for each( var thisStatus:XML in ptstatus..status ) 
				
			for each( var thisPSA:XML in patientPSA..psa) 
			{
				var ptPSA:PatientPSAVO= new PatientPSAVO();
				ptPSA.id= thisPSA.id;	
				ptPSA.ptid = thisPSA.ptid;				
				ptPSA.date = thisPSA.date;								
				ptPSA.value = thisPSA.value;		
				
				// add recs to array
				PSAList.push(ptPSA);
			}			
			return PSAList;
		}

	}
}