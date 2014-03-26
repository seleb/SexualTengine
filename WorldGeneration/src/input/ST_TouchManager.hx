package input;
import flash.events.TouchEvent;
import flash.Lib;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import input.ST_TouchManager.ST_Touch;
/**
 * ...
 * @author Sean
 */
class ST_Touch {
	public var x:Float = 0;
	public var y:Float = 0;
	public function new(_x:Float, _y:Float) {
		x = _x;
		y = _y;
	}
	public function toString():String{
		return "x: " + x + ", y:" + y;
	}
}
class ST_TouchManager {
	public static var touches:Map<Int,ST_Touch> = new Map<Int,ST_Touch>();
	public function new() 
	{
		//if multitouch is supported, switch the input mode to ignore gestures and only do touch points
		trace(Multitouch.supportsTouchEvents);
		if (Multitouch.supportsTouchEvents) {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			//try{
			//	Multitouch.mapTouchToMouse = false;
			//}catch (e:Dynamic) {
			//	trace(e);
			//}
			Lib.current.stage.addEventListener(TouchEvent.TOUCH_BEGIN, ST_TouchManager.touchBegin);
			Lib.current.stage.addEventListener(TouchEvent.TOUCH_END, ST_TouchManager.touchEnd);
			Lib.current.stage.addEventListener(TouchEvent.TOUCH_MOVE, ST_TouchManager.touchMove);
		}
		
	}
	
	private static function touchBegin(evt:TouchEvent):Void {
		touches.set(evt.touchPointID, new ST_Touch(evt.localX, evt.localY));
	}
	
	private static function touchEnd(evt:TouchEvent):Void {
		touches.remove(evt.touchPointID);
	}
	
	private static function touchMove(evt:TouchEvent):Void {
		touches.get(evt.touchPointID).x = evt.localX;
		touches.get(evt.touchPointID).y = evt.localY;
	}
	
}