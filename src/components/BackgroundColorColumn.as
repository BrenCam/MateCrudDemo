package components
{
import mx.controls.dataGridClasses.DataGridColumn;

public class BackgroundColorColumn extends DataGridColumn
{

	public function BackgroundColorColumn()
	{
		super();
	}

	/**
	 *  The value of the datafield that, if below the threshhold
	 *  causes the background color to appear
	 */
	public var threshhold:Number;

	/**
	 *  The background color that will appear if the value is below
	 *  the threshhold
	 */
	//public var threshholdColor:uint = 0x00FF00;			// Green
	public var threshholdColor:uint = 0x008B45;		//SpringGreen

}

}