package events
{
	
	import flash.events.Event;

	public class NavigationEvent extends Event
	{
		/*-.........................................Constants..........................................*/
		
		public static const LOGIN: String 			= "LoginNavigationEvent";
		public static const MAIN_UI: String 		= "LoginNavigationEvent";		
		public static const LOGOUT: String 			= "LogoutNavigationEvent";
		public static const PATIENT_LIST: String 	=	"PatientListNavigationEvent";
		public static const PATIENT_REGISTER: String = "PatientRegistrationNavigationEvent";
		public static const PATIENT_STATUS: String = "PatientStatusNavigationEvent";
		public static const PSA_LIST: String 	=	"PSAListNavigationEvent";
		public static const PSA_DETAIL: String = "PSADetailNavigationEvent"	;
		public static const ABOUT_INFO: String = "AboutInfoNavigationEvent"	;
		
			
		/*-.........................................Constructor..........................................*/	
		public function NavigationEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}