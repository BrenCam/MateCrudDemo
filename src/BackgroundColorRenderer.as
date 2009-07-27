package  
{
import mx.controls.DataGrid;
import mx.controls.dataGridClasses.DataGridItemRenderer;
import mx.controls.dataGridClasses.DataGridListData;
import components.BackgroundColorColumn;

public class BackgroundColorRenderer extends DataGridItemRenderer
{
		public static const millisecondsPerMinute:int = 1000 * 60;
		public static const millisecondsPerHour:int = 1000 * 60 * 60;
		public static const millisecondsPerDay:int = 1000 * 60 * 60 * 24;
			
	public function BackgroundColorRenderer()
	{
		super();
	}

	/**
	 *  DataGridItemRenderer extends TextField and has a slightly different
	 *  validation mechanism than UIComponent-based widgets.  All visuals
	 *  are resolved within the validateNow call.  We apply the background
	 *  here
	 */
	override public function validateNow():void
	{
		super.validateNow();

		if (!listData) 
		{
			// item renderers are recycled so you have to make sure
			// that all code paths lead to a known state.
			background = false;
			return;
		}

		var dgListData:DataGridListData = listData as DataGridListData;
		var dataGrid:DataGrid = dgListData.owner as DataGrid;

		// comment this out if you want to see the background over the
		// selection and highlight indicators
		if (dataGrid.isItemSelected(data) || dataGrid.isItemHighlighted(data))
		{
			// clear the background so you can see the selection/highlight colors
			background = false;
			return;
		}

		var column:BackgroundColorColumn = dataGrid.columns[dgListData.columnIndex];
		
		// Check date within range - highlight stale date values - threshold indicates day count
		var dayCount:int = int (column.threshhold);
		var str:String = data[column.dataField];
		
		var now:Date = new Date()
		var strArray:Array = str.split('/');
		//var dateval:Date = new Date (strArray[2],int(strArray[1]-1),int(strArray[0]));  //month starts @ 0
		var dateval:Date = new Date (str);  //pass string
		
		// Conmpute # msecs on 30 days (1000 *60*60) *24 *30
		//var msecthreshold:Number = 30 * millisecondsPerDay
		
		var msecthreshold:Number = dayCount * millisecondsPerDay;
		var tnow:Number = now.getTime();
		var tprev:Number = dateval.getTime();
		var ddiff:Number = tnow-tprev;
		var days:Number = ddiff/millisecondsPerDay;
		
				
		var datediff:Number = now.getTime() - dateval.getTime();
		
		//trace ('Datediff/Threshold (msecs)/Date: ' + (datediff/1000).toString() + ' ; ' + (msecthreshold/1000).toString()  + '; ' + str);
		switch (datediff >= msecthreshold)

		{
			case true:	
				//trace ('Stale Data Found: ' + str);		
				background = true;
				backgroundColor = column.threshholdColor;
				break;				
			default:					
				//background = false;
				//trace ('Fresh Data Found: ' + str);		
				background = true;
				//backgroundColor = 0x00FF00;		//green
				//backgroundColor = 0x008B45;		//SpringGreen
				//backgroundColor = 0x2E8B57;
				//backgroundColor =  0x2E8B57;		//seagreen
				//backgroundColor =  0x00C957;		//emerald green
				backgroundColor =  0x4BB74C;		//M&M Green	
				

				break;				

		}	
	
}

}
}