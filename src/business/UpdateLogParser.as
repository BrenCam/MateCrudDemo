package business
{
	import mx.controls.DateField;
	
	import vos.UpdateLogVO;
	
	public class UpdateLogParser
	{
		
		/*-.........................................Methods..........................................*/
		
		public function loadLogFromXML(updateLog:XML):Array 
		{
			var logList:Array = new Array();

				
			for each( var thisLog:XML in updateLog..log) 
			{
				var zztempLog:UpdateLogVO= new UpdateLogVO();
				zztempLog.id= thisLog.id;	
				zztempLog.recid = thisLog.recid;
				zztempLog.rectype = thisLog.rectype;				
				zztempLog.updatetype = thisLog.updatetype;	
				// Convert String to a Date type			
				//zztempLog.date= (thisLog.date)as Date;
				
				var logdateString:String = thisLog.date;
                var logdate:Date = DateField.stringToDate(logdateString, "MM/DD/YYYY");
				//zztempLog.date= new Date(thisLog.date) ;
				zztempLog.date= logdate;
				zztempLog.user= thisLog.user;
				// add recs to array
				logList.push(zztempLog);
			}			
			return logList;
		}

	}
}