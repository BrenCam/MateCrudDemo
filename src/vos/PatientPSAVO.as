package vos
{	
	[Bindable]
	public class PatientPSAVO 
	{
		/*-.........................................Properties..........................................*/
		public var id : uint;
		public var ptid : uint;
		public var date: String;		
		public var value: String;
		
		static public var currentPSAIndex : uint = 1000;

					
		/*-.........................................Constructor..........................................*/
		public function PatientPSAVO(	id : uint =			0,
									ptid:uint = 0,
									date:String = "", 
									value:String=	null)
		{
			//this.id = ( id == 0 ) ?  currentPSAIndex += 1 : id;
			if (id == 0) {
				currentPSAIndex +=1;
				this.id = currentPSAIndex;
			}
			else {
				this.id = id;
			}
			this.ptid = ptid;
			this.date= date;
			this.value= value
		}
		
		/*-.........................................Methods..........................................*/
		public function copyFrom(newPSA:PatientPSAVO):void 
		{
			this.id = newPSA.id;
			this.ptid = newPSA.ptid;	
			this.date = newPSA.date;	
			this.value = newPSA.value;	
		}
	}
}