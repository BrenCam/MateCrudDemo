package  components
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import mx.controls.Label;
	

	public class DateItemRenderer extends Label
	{
		public static const millisecondsPerMinute:int = 1000 * 60;
		public static const millisecondsPerHour:int = 1000 * 60 * 60;
		public static const millisecondsPerDay:int = 1000 * 60 * 60 * 24;
		
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			var m:Matrix = new Matrix();
			m.createGradientBox(unscaledWidth,unscaledHeight);
			
			var g:Graphics = graphics;
			var colors:Array = assignColors(data);
			
			g.clear();
			g.beginGradientFill(GradientType.LINEAR, colors, [0.2,0.6], [0,255], m);
			
			// the rectangle is drawn a little high and a little tall to compensate for the gap
			// the DataGrid introduces between rows.
			g.drawRect(0, -2, unscaledWidth, unscaledHeight+4 );
			g.endFill();
		}
		
		// Create private function to set color values based on business rules
		// ??Override this for other cols ??
		private function assignColors(data:Object):Array 
		{
			var colors:Array = [0x0000FF,0x0000FF];			// Blue default
			//trace ('assign colors');
			// Date is in col1 (in dd/mm/yyyy format);
			// Set color based on date value 
			// Red > 30 Days past; Green <= 30 days past
			// 
			var str:String = data.psalast;
			var now:Date = new Date()
			var strArray:Array = str.split('/');
			
			//var dateval:Date = new Date (strArray[2],int(strArray[1]-1),int(strArray[0]));  //month starts @ 0
			
			var dateval:Date = new Date (str);  //pass string - 11/12/2008 - Bug Fix

			// Compute # msecs on 30 days (1000 *60*60) *24 *30
			var msecthreshold:Number = 30 * millisecondsPerDay
			var datediff:Number = now.getTime() - dateval.getTime();
			
			//trace ('Datediff/Threshold (msecs)/Date: ' + (datediff/1000).toString() + ' ; ' + (msecthreshold/1000).toString()  + '; ' + str);
			switch (datediff >= msecthreshold)
			{
				case true:			
					colors =  [0xFF0000,0xFF0000];			// Red
					break;				
				default:					
					//colors =  [0x00FF00,0x00FF00];			// Green	
					colors =  [0x008B450,0x008B45];			// Green	
															
			}	
					  			
			return colors
		}
				
	}
}