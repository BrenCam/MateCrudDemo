package business
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import vos.UpdateLogVO;
	
	public class UpdateLogManager extends EventDispatcher 
	{
		//
		// Manager/Model Class maintains data - 
		// data changes are injected into views by Binding
		// 
		/*-.........................................Properties..........................................*/
		
		private var _updateLogList:ArrayCollection;
		private var newid:uint = 0;
				
						
		// Getter/Setter to get status dtls for a selected Patient (returns one record)
		
		/*-.........................................Setters and Getters..........................................*/
		
		[Bindable (event="UpdateLogAdded")]
		public function get UpdateLogList():ArrayCollection
		{
			return _updateLogList;
		}
		
		//Update Confirmation Message
		private var _updateConfirmation:String;

		[Bindable (event="UpdateLogAdded")]
		public function get updateConfirmation():String {
			return _updateConfirmation;
		}
		
		/*-.........................................Methods..........................................*/
		
		public function saveLogList(updateLogs:Array):void {
			_updateLogList = new ArrayCollection(updateLogs);
			dispatchEvent(new Event('UpdateLogAdded'));
		}
		
		public function addUpdateLog (updateLog:UpdateLogVO) : void {

			trace ('UpdateLogManager - addUpdateLog - Entry');
			// Add new rec to log 
			// Currently Saving data to memory (array collection)
			// Eventually modify this to save to a real back end db (MySql; Google App Engine; Other) 
			// add new entry into ArrayCollection
			var zzUpdateLog:UpdateLogVO = new UpdateLogVO ();
			// weird bug here - creating temp var to avoid losing autoinc value
			newid = zzUpdateLog.id;
			zzUpdateLog.date = updateLog.date;
			zzUpdateLog.recid = updateLog.recid;
			zzUpdateLog.updatetype = updateLog.updatetype;			
			zzUpdateLog.rectype = updateLog.rectype;
			zzUpdateLog.user = updateLog.user;
			zzUpdateLog.id = newid;
			// Update array collection with new record
			_updateLogList.addItem(zzUpdateLog);
			_updateConfirmation = 'New Log record added : ID = ' + newid.toString();
			//trigger rebind - this will refresh the Update History display
			dispatchEvent(new Event('UpdateLogAdded'));
			trace ('UpdateLogManager - addUpdateLog - Exit : Rec ID = ' + newid.toString());
		}	
	}
}