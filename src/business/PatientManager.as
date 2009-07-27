package business
{
	import com.asfusion.mate.events.Dispatcher;
	
	import events.*;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.controls.Alert;
	
	import vos.PatientVO;
	import vos.PtStatusVO;
	import vos.SearchVO;
	import vos.UpdateLogVO;
	
	public class PatientManager extends EventDispatcher 
	{
		//
		// Manager/Model Class maintains data - 
		// data changes are injected into views by Binding
		// 
		/*-.........................................Properties..........................................*/
		
		private var _patientList:ArrayCollection;		
		private var _famHistFather:Boolean;
		private var _famHistBrother:Boolean;
		private var _famHist:String;
		private var _patient:PatientVO;
		
		// Latest Search Results
		private var _searchResults:ArrayCollection;
		private var _viewStackIndex:int;
		
		/*-.........................................Setters and Getters..........................................*/
		
		[Bindable (event="patientListChanged")]
		public function get patientList():ArrayCollection
		{
			return _patientList;
		}
		
		[Bindable (event="patientChanged")]
		public function get patient():PatientVO
		{
			return _patient;
		}
		
		//For DG Display
		private var _showDGStatus:Boolean;
		[Bindable (event="patientChanged")]		
		public function get showDGStatus():Boolean					//Getter
		{
			return _showDGStatus;
		}

		[Bindable (event="patientChanged")]
		public function get famHist():String{
			return _famHist;
		}	

		[Bindable (event="patientChanged")]
		public function get famHistFather():Boolean {
			return _famHistFather;
		}	
		
		[Bindable (event="patientChanged")]
		public function get famHistBrother():Boolean {
			return _famHistBrother;
		}
		
		// For Tree View Synching
		[Bindable (event="patientChanged")]
		public function get selectedIndex():int{
			return 1;					// hard coded value for initial testing
			// Enable after updates to relevant Event Map/Injection Map
			//return _viewStackIndex;
		}
		
		// For results search
		[Bindable (event="patientSearchCompleted")]
		public function get searchResults():ArrayCollection
		{
			return _searchResults;
		}
		
		//Update Confirmation Message
		private var _updateConfirmation:String;
		[Bindable (event="PatientDataChanged")]
		public function get updateConfirmation():String {
			return _updateConfirmation;
		}		
		
		// Variables for logging updates
		private var newid:uint = 0;
		private var updatetype:String ="";						
		/*-.........................................Methods..........................................*/
		
		public function testEvent(ptStatus:PtStatusVO):void {
			
			Alert.show('PatientManager.testEvent - Patient ID: ' );	
		}
		
		public function setViewStackIndex(navEvt:NavigationEvent):void {
			// Used for application navigation 
			// next screen to display is defined  by index/Event string
			_viewStackIndex = 1;
			switch (navEvt.type) {
				case NavigationEvent.ABOUT_INFO:
					_viewStackIndex = 8;			// About Panel
					break;
					
				default:
					_viewStackIndex = 1;			// Pt Detail Panel
			}
		}
		
		
		
		// -----------------------------------------------------------
		public function savePatientList(patients:Array):void {
			_patientList = new ArrayCollection(patients);
			dispatchEvent(new Event('patientListChanged'));
		}
		
		// -----------------------------------------------------------
		public function selectPatient(patient:PatientVO):void {
			// Set any bound values here - these will be injected into the view
			
			trace ("Patient Manager.selectPatient:"); 			
			_patient = patient;
			if (patient != null)  {
				trace ("Patient Manager.selectPatient - PatientLastName: " + patient.lastname); 			
				_famHist = patient.famHist;
				_famHistFather = patient.famHistFather;
				_famHistBrother = patient.famHistBrother;		
				// Set/Display DG Status by default 
				_showDGStatus = true;
				if (patient.lastname == "") {
					_showDGStatus = false;				
				}
				dispatchEvent(new Event('patientChanged'));
				}
		}
		
		public function resetPatient(ptStatus:PtStatusVO):void {
			// Coming from other (status) screen - so need to reset/update the selected patient 
			// based on the Pt ID passed value passed
			// Get PT ID and search the array collection for a match
			
			var id:String;
			id = ptStatus.id.toString();
			//Alert.show('PatientManager.resetPatient - Patient ID: ' + id);			
			findMatch (id);
			dispatchEvent(new Event('patientChanged'));										
		}

		
		private function findMatch(selectedid:String):void {
			// Search patient array for match on patient ID
			import mx.collections.IViewCursor;
			var cursor:IViewCursor;						
			var mySort:Sort = new Sort();
			mySort.fields = [new SortField('id')];
			_patientList.sort = mySort;
			_patientList.refresh();
			
			cursor = _patientList.createCursor(); 
			var searchObject:Object = {id:selectedid} 
			if (cursor.findAny(searchObject))
			{
				// Populate VO/DTO with these results				
	 			// Alert.show('findMatch - Patient ID: ' + cursor.current.id);
				_patient = new PatientVO();
				_patient.id = cursor.current.id;
				_patient.firstname= cursor.current.firstname;
				_patient.lastname = cursor.current.lastname;	
				_patient.mrn= cursor.current.mrn;	
				_patient.dob = cursor.current.dob;
				_patient.famHist = cursor.current.famHist;
				_patient.famHistBrother= cursor.current.famHistBrother;
				_patient.famHistFather= cursor.current.famHistFather;
				_patient.email = cursor.current.email;
				_patient.ethnicity = cursor.current.ethnicity;
			}									 
		}		
		
		// -----------------------------------------------------------
		public function deletePatient (patient:PatientVO) : void {
			
			_patientList.removeItemAt(_patientList.getItemIndex(patient));
			_updateConfirmation = 'Patient record Deleted : ID = ' +patient.id.toString();
			updatetype = "Delete";	
			refreshLogList(patient.id);			
			// clear out the selected Patient just in case
			selectPatient(null);
		}

		// -----------------------------------------------------------
		public function savePatient (patient:PatientVO) : void {

			// assume the edited fields are not an existing PatientVO, but a new PatientVO
			// and set the ArrayCollection index to -1, which means this PatientVO is not in our existing
			// PatientVO list anywhere
			var dpIndex : int = -1;
			trace ('PatientManager - savePatient');
			// loop thru the Patient list
			for ( var i : uint = 0; i < patientList.length; i++ ) {
				// if the id of the incoming PatientVO matches an PatientVO already in the list
				if ( patientList[i].id == patient.id ) {
					// set our ArrayCollection index to that PatientVO position
					dpIndex = i;
				}
			}

			// if it was an existing PatientVO already in the ArrayCollection
			// then update
			if ( dpIndex >= 0 ) {
				// update that PatientVO's values
				(patientList.getItemAt(dpIndex) as PatientVO).copyFrom(patient);
				newid = (patientList.getItemAt(dpIndex) as PatientVO).id;
				updatetype = "Update"
				_updateConfirmation = 'Selected Patient record updated: ID = ' + newid.toString();
				
			}
			// otherwise, if it didn't match any existing PatientVOs
			// add new 
			else {
				trace ('PatientManager.SavePatient- Adding New Patient');
				
				// add the temp PatientVO to the ArrayCollection
				var tempPatient:PatientVO = new PatientVO();
				tempPatient.copyFrom(patient);
				patientList.addItem(tempPatient);
				// Also need to initialize new PtStatus record for this PatientVO
				// ??Dispatch event ??
				
				// to make it here the fields must have been valid
				// broadcast the event - PatientVO status manager will invoke add new method
				var event:PtStatusEvent = new PtStatusEvent (PtStatusEvent.ADD);
				//event.PatientVO = tempPatientVO;					
				event.ptStatus = new PtStatusVO();
				// populate with basic data				
				event.ptStatus.id = 0;
				event.ptStatus.ptid = tempPatient.id;					// Set FK Value	
				newid = tempPatient.id;			
				event.ptStatus.lastname = tempPatient.lastname;
				event.ptStatus.bxlast = '1/1/1900';
				event.ptStatus.surgery = '1/1/1900';
				event.ptStatus.fulast = '1/1/1900';
				event.ptStatus.psalast = '1/1/1900';
				updatetype = "Add"
				_updateConfirmation = 'New Patient record Created: ID = ' + newid.toString();
				//!!! Note: Use Mate Dispatcher here - otherwise event is not processed in Event Map !!!
				trace ('PatientManager.SavePatient- Dispatch PtStatusEvent.ADD');
				var myDispatcher:Dispatcher = new Dispatcher();								
				myDispatcher.dispatchEvent(event);
			}
			// clear out the selected PatientVO
			// After save or update need update log history
			refreshLogList(patient.id);			
			selectPatient(null);			
		}
	
		private function refreshLogList(id:uint):void {

			// Refresh confirmation message
			dispatchEvent(new Event('PatientDataChanged'));
			// Update History Log (Dispatch Event via Mate Event Dispatcher)
			// Populate Event Object 
			// Set update confirmation text -
						 
			var evt:UpdateLogEvent = new UpdateLogEvent(UpdateLogEvent.ADD);
			evt.updateLog = new UpdateLogVO();
			evt.updateLog.recid = id;
			evt.updateLog.rectype = "Registration";
			evt.updateLog.updatetype= updatetype;
			evt.updateLog.user= "MATE";
			var now:Date = new Date();
			evt.updateLog.date= now;
			var mateDispatcher:Dispatcher = new Dispatcher();
			trace ('Patient Manager - Dispatching Update Log Event');
			mateDispatcher.dispatchEvent(evt);
		}

		public function searchPatients(searchArgs:SearchVO):void {
			// Search the patient array for selected patient(s)
			_searchResults = new ArrayCollection();			//?? Check if already exists??
			//var dpIndex : int = -1;
			trace ('PatientManager - search for:' );
			// loop thru the Patient list - add matches to 
			for ( var i : uint = 0; i < patientList.length; i++ ) {
				// Look for (partial) match on pt name or MRN (reg ex search)
				switch (searchArgs.searchtype) {
					case 'mrn':
						if (patientList[i].mrn.search(searchArgs.searchvalue) >=0) {
							_searchResults.addItem(patientList[i]);
						}
						break;
						
					case 'name':
						if (patientList[i].lastname.search(searchArgs.searchvalue) >=0) {
							_searchResults.addItem(patientList[i]);
						}
						break;
				}
			}
			dispatchEvent (new Event ('patientSearchCompleted'));
		}
	
	}
}