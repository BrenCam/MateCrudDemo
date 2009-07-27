package events
{
	import vos.PatientPSAVO;
	
	import flash.events.Event;

	public class PtPSAEvent extends Event
	{
		/*-.........................................Constants..........................................*/
		
		public static const ADD: String 		= "addPSAEvent";
		public static const SELECT: String 		= "selectPSAEvent";
		public static const DELETE: String 		= "deletePSAEvent";
		public static const SAVE: String 		= "savePSAEvent";
		public static const SAVE_COMPLETED: String 		= "saveCompletedPSAEvent";
		
		public static const CANCEL_EDIT: String = "cancelEditPSAEvent";
		
		/*-.........................................Properties..........................................*/
		public var patientPSA:PatientPSAVO;		
		
		/*-.........................................Constructor..........................................*/
		
		public function PtPSAEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}