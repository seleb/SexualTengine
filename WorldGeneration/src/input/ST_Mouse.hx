package input;

/**
 * ...
 * @author Ryan
 */
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;

class ST_Mouse {
	/** Whether the left mouse button is currently pressed */
	public static var leftPressed:Bool = false;
	/** Whether the left mouse button was just released */
	public static var leftJustReleased:Bool = false;
	/** Whether the left mouse button was just pressed */
	public static var leftJustPressed:Bool = false;
	
	/** Whether the right mouse button is currently pressed */
	public static var rightPressed:Bool = false;
	/** Whether the right mouse button was just released */
	public static var rightJustReleased:Bool = false;
	/** Whether the right mouse button was just pressed */
	public static var rightJustPressed:Bool = false;
	
	/** Whether the middle mouse button is currently pressed */
	public static var middlePressed:Bool = false;
	/** Whether the middle mouse button was just released */
	public static var middleJustReleased:Bool = false;
	/** Whether the middle mouse button was just pressed */
	public static var middleJustPressed:Bool = false;
	
	/** Values : 1 => scrolling up, 0 => no scroll, -1 => scrolling down*/
	public static var mouseWheel:Float = 0.0;
	/** X position of mouse*/
	public static var x:Float = 0.0;
	/** Y position of mouse*/
	public static var y:Float = 0.0;
	
	
	public function new(){
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, ST_Mouse.onLeftMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, ST_Mouse.onLeftMouseUp);
		
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, ST_Mouse.onRightMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, ST_Mouse.onRightMouseUp);
		
		Lib.current.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, ST_Mouse.onMiddleMouseDown);
		Lib.current.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, ST_Mouse.onMiddleMouseUp);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, ST_Mouse.clearJust);
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private static function onLeftMouseDown(evt:MouseEvent):Void {
		if (!leftPressed) {
			leftJustPressed = true;
		}
		leftPressed = true;
	}private static function onLeftMouseUp(evt:MouseEvent):Void {
			leftPressed = false;
			leftJustReleased = true;
	}
	
	private static function onRightMouseDown(evt:MouseEvent):Void {
		if (!rightPressed) {
			rightJustPressed = true;
		}
		rightPressed = true;
	}private static function onRightMouseUp(evt:MouseEvent):Void {
			rightPressed = false;
			rightJustReleased = true;
	}
	
	private static function onMiddleMouseDown(evt:MouseEvent):Void {
		if (!middlePressed) {
			middleJustPressed = true;
		}
		middlePressed = true;
	}private static function onMiddleMouseUp(evt:MouseEvent):Void {
			middlePressed = false;
			middleJustReleased = true;
	}
	
	private static function onMouseWheel(evt:MouseEvent):Void {
		mouseWheel = evt.delta;
	}
	
	private static function onMouseMove(evt:MouseEvent):Void {
		x = evt.localX;
		y = evt.localY;
	}
	
	/** Clears on ENTER_FRAME. */
	private static function clearJust(evt:Event) {
		leftJustPressed = false;
		leftJustReleased = false;
		rightJustPressed = false;
		rightJustReleased = false;
		middleJustPressed = false;
		middleJustReleased = false;
		mouseWheel = 0.0;
	}
}