package vos
{	
	[Bindable]
	public class PatientVO 
	{
		/*-.........................................Properties..........................................*/
		public var id : uint;
		public var firstname : String;
		public var lastname : String;
		public var mrn : String;
		public var email : String;
		public var ethnicity :String;
		public var dob: Date;
		public var famHist : String;
		public var famHistBrother : Boolean;
		public var famHistFather : Boolean;
						
		static public var currentIndex : uint = 1000;
		
		/*-.........................................Constructor..........................................*/
		public function PatientVO(	id : uint =			0, 
									firstname : String =		"", 
									lastname : String =		"", 
									mrn : String =		"", 
									email : String =	"", 
									ethnicity:String = "",
									dob : Date =		null, 
									famHist: String = "NO",
									famHistBrother:Boolean = false,
									famHistFather:Boolean = false									
									) 
		{
			this.id = ( id == 0 ) ?  currentIndex += 1 : id;
			this.firstname = firstname;
			this.lastname = lastname;
			this.mrn = mrn;
			this.email = email;
			this.ethnicity = ethnicity;			
			this.dob=  ( dob == null ) ?  new Date() : dob;
			this.famHist = famHist;
			this.famHistBrother = famHistBrother;
			this.famHistFather = famHistFather;
		}
		
		/*-.........................................Methods..........................................*/
		public function copyFrom(newPatientVO:PatientVO):void 
		{
			this.id = newPatientVO.id;
			this.email = newPatientVO.email;
			this.ethnicity = newPatientVO.ethnicity;
			this.firstname = newPatientVO.firstname;
			this.lastname = newPatientVO.lastname;
			this.mrn= newPatientVO.mrn;
			this.dob = newPatientVO.dob;	
			this.famHist = newPatientVO.famHist;
			this.famHistBrother = newPatientVO.famHistBrother;
			this.famHistFather = newPatientVO.famHistFather;
		}
	}
}