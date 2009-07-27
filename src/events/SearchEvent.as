package events
{
	import vos.SearchVO;
	import flash.events.Event;

	public class SearchEvent extends Event
	{
		/*-.........................................Constants..........................................*/
		
		public static const SEARCH: String 		= "searchEvent";
		
		/*-.........................................Properties..........................................*/
		public var searchArgs:SearchVO;
		
		/*-.........................................Constructor..........................................*/
		
		public function SearchEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}