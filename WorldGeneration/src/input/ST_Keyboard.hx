package input;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.ui.Keyboard;
import Map;

/** Utility class for keyboard input. <strong>Requires that a KeyboardUtil object be initialized before the static members will be of any use.</strong> */
class ST_Keyboard{
	
	/** Currently pressed keys */
	private static var pressedKeys:Map<Int,Int> = new Map<Int,Int>();
	/** Keys pressed last frame */
	private static var justPressedKeys:Map<Int,Int> = new Map<Int,Int>();
	/** Keys released last frame */
	private static var justReleasedKeys:Map<Int,Int> = new Map<Int,Int>();
	/** Last key released */
    private static var lastKeyUp:Int;
	
	/** Access flash key codes using strings <em>(Only WASD, XZ, arrows, and space because I'm too lazy to do the rest)</em> */
	public static var keyStrings:Map < String, Int > = [
	"LEFT"	=>	37,
	"RIGHT"	=>	39,
	"UP"	=>	38,
	"DOWN"	=>	40,
	"W"		=>	87,
	"A"		=>	65,
	"S"		=>	83,
	"D"		=>	68, 
	"X"		=>	88,
	"Z"		=>	90,
	"SPACE"	=>	32];
	
	/** Attaches event listeners so that the static stuff actually works. */
	public function new(){
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, ST_Keyboard.keyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, ST_Keyboard.keyUp);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, ST_Keyboard.clearJust);
	}
	
	/** Adds a pressed key to the map of pressedKeys and justPressedKeys. */
	private static function keyDown(evt:KeyboardEvent) {
		if (!pressedKeys.exists(evt.keyCode)){
			pressedKeys.set(evt.keyCode, evt.keyCode);
			justPressedKeys.set(evt.keyCode, evt.keyCode);
		}
	}
	
	/** Removes and adds a pressed key from the map of pressedKeys and justReleasedKeys, respectively. */
	private static function keyUp(evt:KeyboardEvent){
		pressedKeys.remove(evt.keyCode);
		justReleasedKeys.set(evt.keyCode,evt.keyCode);
		lastKeyUp = evt.keyCode;
	}
	
	/** Clears justPressedKeys and justReleasedKeys on ENTER_FRAME. */
	public static function clearJust(evt:Event){
		for (key in justPressedKeys.keys()) {
			justPressedKeys.remove(key);
		}
		for (key in justReleasedKeys.keys()) {
			justReleasedKeys.remove(key);
		}
	}
	
	/** Returns all keys currently pressed as a map. */
	public static function getPressedKeys():Map<Int,Int> {
		return pressedKeys;
	}
	
	/** Returns all keys pressed in the last frame as a map. */
	public static function getJustPressedKeys():Map<Int,Int> {
		return justPressedKeys;
	}
	
	/** Returns all keys released in the last frame as a map. */
	public static function getJustReleasedKeys():Map<Int,Int> {
		return justReleasedKeys;
	}

	/**  Returns the last key released. */
    public static function getLastKeyUp():Int{
        return lastKeyUp;
    }
	
	
	
	
	
	/**
	 * If any of the keys in the given array are pressed, returns true. Otherwise, returns false.
	 * @param	args An array of strings representing keys. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args are currently pressed, false otherwise.
	*/
	public static function isPressed(args:Array<String>):Bool {
		var i:String;
		var res:Bool = false;
		while (args.length != 0) {
			i = args.pop();
			if (pressedKeys.exists(keyStrings.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * If any of the keys in the given array was pressed in the last frame, returns true. Otherwise, returns false.
	 * @param	args An array of strings representing keys. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args were just pressed, false otherwise.
	*/
	public static function isJustPressed(args:Array<String>):Bool {
		var i:String;
		var res:Bool = false;
		while (args.length != 0) {
			i = args.pop();
			if (justPressedKeys.exists(keyStrings.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * If any of the keys in the given array was released in the last frame, returns true. Otherwise, returns false.
	 * @param	args An array of strings representing keys. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args were just released, false otherwise.
	*/
	public static function isJustReleased(args:Array<String>):Bool {
		var i:String;
		var res:Bool = false;
		while (args.length != 0) {
			i = args.pop();
			if (justReleasedKeys.exists(keyStrings.get(i))) {
				res = true;
			}
		}
		return res;
	}
}