package vos
{	
	[Bindable]
	public class PtStatusVO 
	{
		/*-.........................................Properties..........................................*/
		public var id : uint;
		public var ptid : uint;
		public var lastname: String;		
		public var surgery: String;
		public var fulast: String;
		public var psalast : String;
		public var bxlast: String;
		
  		static public var currentIndex : uint = 1000;

		/*-.........................................Constructor..........................................*/
		public function PtStatusVO(	id : uint =	0,
									ptid : uint = 0,
									lastname:String = "", 
									surgery:String=	null, 
									fulast:String=	null, 
									psalast:String=	null, 
									bxlast : String =	null ) 
		{
			this.id = ( id == 0 ) ?  currentIndex += 1 : id;
			this.ptid = ptid;
			this.lastname = lastname;
			this.surgery = surgery;
			this.fulast = fulast;
			this.psalast = psalast;
			this.bxlast=  bxlast
		}
		
		/*-.........................................Methods..........................................*/
		public function copyFrom(newPtStatus:PtStatusVO):void 
		{
			this.id = newPtStatus.id;
			this.ptid = newPtStatus.ptid;
			this.lastname = newPtStatus.lastname;
			this.surgery = newPtStatus.surgery;
			this.fulast = newPtStatus.fulast;
			this.psalast = newPtStatus.psalast;
			this.bxlast=  newPtStatus.bxlast			
		}
	}
}