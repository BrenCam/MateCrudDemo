package business
{
	import mx.controls.Alert;
	import vos.PatientVO;
	import vos.PtStatusVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	public class PtStatusManager extends EventDispatcher 
	{
		/*-.........................................Properties..........................................*/
		
		private var _ptStatusList:ArrayCollection;
		
		/*-.........................................Setters and Getters..........................................*/
		
		[Bindable (event="statusListChanged")]
		// Getter/Setter to get data for all patients
		public function get ptStatusList():ArrayCollection
		{
			// Getter/Setter Property - Note: Only Properties are bindable
			return _ptStatusList;
		}
		
		// Getter/Setter to get status dtls for a selected Patient (returns one record)
		private var _ptStatus:PtStatusVO;

		//[Bindable (event=PatientEvent.SELECT)]
				
		[Bindable (event="patientChanged") ]			
		public function get ptStatus():PtStatusVO
		{
			//?? How to find status for selected patient
			//Alert.show('Getter for - Pt Status');
			//_ptstatus.psalast = '1/1/1990';			//Test Data
			return _ptStatus;
		}
		
		/*-.........................................Methods..........................................*/
		
		// -----------------------------------------------------------
		public function saveStatusList(ptStatus:Array):void {
			
			// Set results in bindable variable
			_ptStatusList = new ArrayCollection(ptStatus);
			dispatchEvent(new Event('statusListChanged'));
		}
		
		public function resetStatus(ptStatus:PtStatusVO):void {

			//Reset the currently selected status record
			_ptStatus = new PtStatusVO();
			_ptStatus = ptStatus;
			//Alert.show('PtStatusManager.resetStatus - Patient ID: ' + _ptStatus.id );			
			//_ptStatus = PtStatus as PtStatus;			
			dispatchEvent(new Event('patientChanged'));			
		}
		
		
		// -----------------------------------------------------------
		public function selectStatus(patient:PatientVO):void {
			//_status = status;
			
			trace ("PtStatusManager.selectStatus:"); 
		
			if (patient != null) 	{			
				var id:String = patient.id.toString();
				//Alert.show('selectStatus - Patient ID: ' + id);
				findMatch (id);
				dispatchEvent(new Event('patientChanged'));
				// Search status array and copy to result vo
				//dispatchEvent(new Event(PatientEvent.SELECT));			
			}
		}
		
		private function findMatch(selectedid:String):void {
			// Search status array for match on patine ID
			import mx.collections.IViewCursor;
			var cursor:IViewCursor;
						
			var mySort:Sort = new Sort();
			mySort.fields = [new SortField('id')];
			_ptStatusList.sort = mySort;
			_ptStatusList.refresh();
			
			cursor = _ptStatusList.createCursor(); 
			var searchObject:Object = {id:selectedid} 
			if (cursor.findAny(searchObject))
			{
				// Populate VO/DTO with these results				
	 			// Alert.show('findMatch - Patient ID: ' + cursor.current.id);

				_ptStatus = new PtStatusVO();
				_ptStatus.id = cursor.current.id;
				_ptStatus.lastname = cursor.current.lastname;				
				_ptStatus.surgery = cursor.current.surgery;
				_ptStatus.fulast = cursor.current.fulast;
				_ptStatus.bxlast = cursor.current.bxlast;
				_ptStatus.psalast = cursor.current.psalast;
			}									 
		}
		
		public function saveStatus (ptStatus:PtStatusVO) : void {

			trace ('PtStatusManager - saveStatus');
			// assume the edited fields are not an existing rec, but a new rec
			// and set the ArrayCollection index to -1, which means this is not in our existing list
			var dpIndex : int = -1;
			
			// loop thru the patient list
			for ( var i : uint = 0; i < ptStatusList.length; i++ ) {
				// if the id of the incoming patient matches an patient already in the list
				if ( ptStatusList[i].id == ptStatus.id ) {
					// set our ArrayCollection index to that patient position
					dpIndex = i;
				}
			}

			// if it was an existing patient already in the ArrayCollection
			// then update
			if ( dpIndex >= 0 ) {
				// syntax - (patientList.getItemAt(dpIndex) as Patient).copyFrom(patient);	
				trace ('PtStatusManager - updating existing status record');
				(ptStatusList.getItemAt(dpIndex) as PtStatusVO).copyFrom(ptStatus);
			}
			// otherwise, if it didn't match any existing patients
			// add new 
			else {
				// add new entry into ptStatus ArrayCollection
				trace ('PtStatusManager - adding new status record');
				var zzptStatus:PtStatusVO = new PtStatusVO();
				zzptStatus.copyFrom(ptStatus);
				ptStatusList.addItem(zzptStatus);
				// Also need to initialize new PtStatus record for this patient
				// ??Dispatch event ??
			}
		}
	}
}