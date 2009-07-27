package business
{
	import events.*;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	
	public class AuthorizationManager
	{
		/*-.........................................Properties..........................................*/
		
		private var dispatcher:IEventDispatcher;
		
		/*-.........................................Constructor..........................................*/
		public function AuthorizationManager(dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;
		}
		
		
		/*-.........................................Methods..........................................*/
		
		public function login(username:String, password:String):Boolean 
		{
			//check hardcoded username and password
			if (username == 'MATE' && password == 'Flex') 
			{
				//login ok, send navigation event - navigate to main UI
				var event:NavigationEvent = new NavigationEvent(NavigationEvent.MAIN_UI);
				dispatcher.dispatchEvent(event);
				//broadcast Login Successful
				var evt:LoginEvent= new LoginEvent(LoginEvent.LOGIN_SUCCESSFUL);
				dispatcher.dispatchEvent(evt);
				
				
				return true;
			}
			return false;
		}
		
		public function logout():void
		{
			//var event:NavigationEvent = new NavigationEvent(NavigationEvent.LOGIN);
			var event:NavigationEvent = new NavigationEvent(NavigationEvent.LOGOUT);
			dispatcher.dispatchEvent(event);
		}

		public function handleFault(evt:Event):void {
			Alert.show ('Generic Application Error: Error Info: ');// + evt.type.toString();
		}

	}
}