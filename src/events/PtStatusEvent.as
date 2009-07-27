package events
{
	import vos.PtStatusVO;
	
	import flash.events.Event;

	public class PtStatusEvent extends Event
	{
		/*-.........................................Constants..........................................*/
		
		public static const SELECT: String 		= "statusListChanged";
		public static const ADD: String 		= "addStatusEvent";
		public static const DELETE: String 		= "deleteStatusEvent";
		public static const SAVE: String 		= "saveStatusEvent";
		
		/*-.........................................Properties..........................................*/
		public var ptStatus:PtStatusVO;
		
		
		/*-.........................................Constructor..........................................*/
		
		public function PtStatusEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}