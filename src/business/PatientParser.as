package business
{
	import vos.PatientVO;
	
	public class PatientParser
	{
		
		/*-.........................................Methods..........................................*/
		
		public function loadPatientsFromXML(patients:XML):Array 
		{
			var patientList:Array = new Array();
				
			for each( var thisPatient:XML in patients..patient ) 
			{
				var patient:PatientVO = new PatientVO();
				patient.email = thisPatient.email;
				patient.id = thisPatient.id;
				//patient.name = thisPatient.name;				
				patient.firstname = thisPatient.firstname;
				patient.lastname = thisPatient.lastname;
				patient.mrn= thisPatient.mrn;
				patient.ethnicity = thisPatient.ethnicity;
				//patient.famHist
				// add recs to array
				patient.dob = new Date(Date.parse(thisPatient.dob));
				patient.famHist = thisPatient.famHist;	
				// Convert XML Text to Boolean Here
				patient.famHistFather = false;
				patient.famHistBrother = false;
				if (thisPatient.famHistFather == 'true'){ patient.famHistFather = true;}
				if (thisPatient.famHistBrother == 'true'){ patient.famHistBrother = true;}
				//patient.famHistFather = thisPatient.famHistFather;	
				//patient.famHistBrother = thisPatient.famHistBrother;
				patientList.push(patient);
			}
			
			return patientList;
		}

	}
}