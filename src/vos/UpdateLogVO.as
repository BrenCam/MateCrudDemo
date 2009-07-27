package vos
{	
	[Bindable]
	public class UpdateLogVO 
	{
		/*-.........................................Properties..........................................*/
		public var id : uint;
		public var recid : uint;
		public var rectype : String;
		public var updatetype : String;
		public var date: Date;		
		public var user: String;
		
		static public var currentUpdateLogIndex : uint = 1000;
					
		/*-.........................................Constructor..........................................*/
		public function UpdateLogVO(	id : uint =			0,
									recid:uint = 0,
									rectype:String = null,
									updatetype:String = null,
									date:Date = null,									 
									user:String=	null)
		{
			//this.id = ( id == 0 ) ?  currentPSAIndex += 1 : id;
			if (id == 0) {
				currentUpdateLogIndex +=1;
				this.id = currentUpdateLogIndex;
			}
			else {
				this.id = id;
			}
			this.recid = recid;
			this.updatetype = updatetype;
			this.date= date;
			this.user= user
		}
		
		/*-.........................................Methods..........................................*/
		public function copyFrom(newUpdateLog:UpdateLogVO):void 
		{
			this.id = newUpdateLog.id;
			this.recid = newUpdateLog.recid;
			this.updatetype = newUpdateLog.updatetype;
			this.date= newUpdateLog.date;
			this.user= newUpdateLog.user
		}
	}
}