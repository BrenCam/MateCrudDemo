package events
{
	import vos.UpdateLogVO;
	import flash.events.Event;

	public class UpdateLogEvent extends Event
	{
		/*-.........................................Constants..........................................*/
		
		public static const ADD: String 		= "addLogEvent";
		
		/*-.........................................Properties..........................................*/
		public var updateLog:UpdateLogVO;
		
		/*-.........................................Constructor..........................................*/
		
		public function UpdateLogEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}