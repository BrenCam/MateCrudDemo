package components
{
import mx.controls.Button;
import flash.events.KeyboardEvent;
import flash.events.Event;
import flash.ui.Keyboard;

[Event( name = "clickCR", type = "flash.events.Event" )]
    
public class ButtonCR extends Button
{

    public static var TEXT_INPUT_CR:String = "clickCR";
    
    public function ButtonCR()
    {
        super();
    }
/**
* Handles initialization of this component.
*/
    override public function initialize() :void
    {
        super.initialize();
        addEventListener(KeyboardEvent.KEY_UP,handleKeyboardEnter,false,0,true);
   }
/**
* Event handler function for KeyBoard <CR> events from this instance.
*/
    protected function handleKeyboardEnter(event:KeyboardEvent):void
    {
        /// <cr> or <enter>
        if (event.keyCode==Keyboard.ENTER)
        {
            var newEvent:Event = new Event(TEXT_INPUT_CR,false);
            dispatchEvent(newEvent);
            
        }
    }
}
}