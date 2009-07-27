package  events
{
	import vos.PatientVO;
	
	import flash.events.Event;

	public class PatientEvent extends Event
	{
		/*-.........................................Constants..........................................*/
		
		public static const ADD: String 		= "addPatientEvent";
		public static const SELECT: String 		= "selectPatientEvent";
		public static const SELECTPSA:String	= "selectPatientEventPSA";
		public static const DELETE: String 		= "deletePatientEvent";
		public static const SAVE: String 		= "savePatientEvent";
		public static const CANCEL_EDIT: String = "cancelEditPatientEvent";
		
		/*-.........................................Properties..........................................*/
		public var patient:PatientVO;
		
		
		/*-.........................................Constructor..........................................*/
		
		public function PatientEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}