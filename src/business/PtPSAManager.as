package business
{
	import com.asfusion.mate.events.Dispatcher;
	
	import events.UpdateLogEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import vos.PatientPSAVO;
	import vos.PatientVO;
	import vos.UpdateLogVO;
	
	public class PtPSAManager extends EventDispatcher 
	{
		//
		// Manager/Model Class maintains data - 
		// data changes are injected into views by Binding
		// 
		/*-.........................................Properties..........................................*/
		
		private var _ptPSAList:ArrayCollection;		
						
		// Getter/Setter to get status dtls for a selected Patient (returns one record)
		//private var _ptStatus:PtStatus;		
		
		/*-.........................................Setters and Getters..........................................*/
		
		[Bindable (event="PSAListChanged")]
		public function get PtPSAList():ArrayCollection
		{
			return _ptPSAList;
		}
		
		private var _ptPSA:PatientPSAVO;
		
		[Bindable (event="PatientPSAChanged")]
		public function get PtPSA():PatientPSAVO
		{
			return _ptPSA;
		}
					
		private var _filteredPSAList:ArrayCollection;
		
		[Bindable (event="PatientSelectionChanged")]
		public function get filteredPSAList():ArrayCollection{
			return _filteredPSAList;
		}
		
		//Update Confirmation Message
		private var _updateConfirmation:String;
		[Bindable (event="PSASaveCompleted")]
		public function get updateConfirmation():String {
			return _updateConfirmation;
		}
		
		private var currentPt:PatientVO;
		private var newid:uint = 0;
		private var updatetype:String ="";
		/*-.........................................Methods..........................................*/
		
		// -----------------------------------------------------------
		public function savePSAList(PatientPSAVO:Array):void {
			_ptPSAList = new ArrayCollection(PatientPSAVO);
			dispatchEvent(new Event('PSAListChanged'));
		}
		
		// -----------------------------------------------------------
		//		public function selectPatient(patient:Patient):void {
		
		public function selectPSA(ptPSA:PatientPSAVO):void {
			// Set any bound values here - these will be injected into the view
						
			trace ("Patient Manager.selectPSA:"); 			
			if (ptPSA!= null)  {
				_ptPSA = ptPSA;
				//trace ("Patient Manager.selectPatient - PatientLastName: " + patient.lastname); 	
				//Move this later
				//_updateConfirmation = 'PSA record updated: ID = ???' ;						
				dispatchEvent(new Event('PatientPSAChanged'));
				}
		}
		
		public function savePSA (ptPSA:PatientPSAVO) : void {

			trace ('PtPSAManager - savePSA');
			
			// Currently Saving data to memory (array collection)
			// Eventually modify this to save to a real back end db (MySql; Google App Engine; Other) 
			
			//Alert.show('PtPSA Manager - savePSA: ');
				
			// assume the edited fields are not an existing rec, but a new rec
			// and set the ArrayCollection index to -1, which means this is not in our existing list
			var dpIndex : int = -1;
			
			// loop thru the patient list
			for ( var i : uint = 0; i < PtPSAList.length; i++ ) {
				// if the id of the incoming patient matches an patient already in the list
				if ( PtPSAList[i].id == ptPSA.id ) {
					// set our ArrayCollection index to that patient position
					dpIndex = i;
				}
			}

			// if it was an existing rec already in the ArrayCollection then update
			if ( dpIndex >= 0 ) {
				trace ('PtPSAManager - updating PSA status record');
				(PtPSAList.getItemAt(dpIndex) as PatientPSAVO).copyFrom(ptPSA);
				newid = (PtPSAList.getItemAt(dpIndex) as PatientPSAVO).id;
				updatetype = "Update"
				_updateConfirmation = 'Selected PSA record updated: ID = ' + newid.toString();
			}
			// otherwise, if it didn't match any existing patients - add new 
			else {
				// add new entry into ptStatus ArrayCollection
				trace ('PtPSAManager - adding new PSA record');
				var zzptPSA:PatientPSAVO = new PatientPSAVO();
				//zzptPSA.copyFrom(ptPSA);
				// weird bug here - creating temp var to avoid losing autoinc value
				newid = zzptPSA.id;
				updatetype = "Add"
				zzptPSA.date = ptPSA.date;
				zzptPSA.value = ptPSA.value;
				zzptPSA.ptid = ptPSA.ptid;
				zzptPSA.id = newid;
				PtPSAList.addItem(zzptPSA);
				_updateConfirmation = 'New PSA record Created: ID = ' + newid.toString();
			}
			
			// After save/update need to refresh the filtered list as well
			refreshPSAList(ptPSA.ptid);
			
			//dispatchEvent(new Event('PSAListChanged'));
//			currentPt = new PatientVO();
//			currentPt.id = ptPSA.ptid;
//			filterPSA (currentPt);
//			// Set update confirmation text - 
//			dispatchEvent(new Event('PSASaveCompleted'));			
		}	
		
		private function refreshPSAList(ptid:uint):void {
			// After save/update need to refresh the filtered list as well
			//dispatchEvent(new Event('PSAListChanged'));
			currentPt = new PatientVO();
			currentPt.id = ptid;
			filterPSA (currentPt);
			// Set update confirmation text - 
			dispatchEvent(new Event('PSASaveCompleted'));
			
			//Update History Log (Dispatch Event via Mate Event Dispatcher)
			// Populate Event Object 
			var evt:UpdateLogEvent = new UpdateLogEvent(UpdateLogEvent.ADD);
			evt.updateLog = new UpdateLogVO();
			evt.updateLog.recid = newid;
			evt.updateLog.rectype = "PSA Data";
			evt.updateLog.updatetype= updatetype;
			evt.updateLog.user= "MATE";
			var now:Date = new Date();
			evt.updateLog.date= now;
			var mateDispatcher:Dispatcher = new Dispatcher();
			trace ('PtPSA Manager - Dispatching Update Log Event');
			mateDispatcher.dispatchEvent(evt);
		}
				
				// -----------------------------------------------------------
		public function deletePSA (ptPSA:PatientPSAVO) : void {
			
			// Modify code to search array for matching record (based on PK Value)
			// Then remove this rec from the datastore- (the rec passed in is a copy of the orig rec??)
			// Also need to refresh the filtered list to reflect the changes 
			// (Note: This is also done when adding or saving) 
			var indx:int = 0;
			for (var i:int = 0; _ptPSAList.length; i++) {
				var zzptPSA:PatientPSAVO = _ptPSAList[i];
				if (ptPSA.id == zzptPSA.id){
					indx = i;
					break;
				}
			}
			//_ptPSAList.removeItemAt(_ptPSAList.getItemIndex(ptPSA));
			_ptPSAList.removeItemAt(indx);
			_updateConfirmation = 'PSA record Deleted : ID = ' + ptPSA.id.toString();
			updatetype = "Delete"
			refreshPSAList(ptPSA.ptid);

			// clear out the selected Patient just in case
			selectPSA(null);
		}
			
		public function filterPSA(patient:PatientVO):void{		
		// ***********************************************************//
		//?? Add new method to filter PSA list based on current Pt ID 
		// 
			// Reset Array Collection to include only a subset of data		
			// (Create a copy of the PSA data that includes filtered subset

			var selectedPatientPSAList:Array;						
			selectedPatientPSAList = new Array();
			//if (PtPSAList != null){
			if (patient != null){				
				// loop thru the PSA list - match on selected patient
				for ( var i : uint = 0; i < PtPSAList.length; i++ ) {
					
					if ( PtPSAList[i].ptid == patient.id ) {
						// Copy matching entries to the new array collection
						var ptPSA:PatientPSAVO = new PatientPSAVO;
						ptPSA.id= PtPSAList[i].id;	
						ptPSA.ptid = PtPSAList[i].ptid;				
						ptPSA.date = PtPSAList[i].date;								
						ptPSA.value = PtPSAList[i].value;		
						// add recs to array
						selectedPatientPSAList.push(ptPSA);						
					}
				}			
				_filteredPSAList = new ArrayCollection(selectedPatientPSAList);			
				dispatchEvent(new Event('PatientSelectionChanged'));
			}
		}
	}
}