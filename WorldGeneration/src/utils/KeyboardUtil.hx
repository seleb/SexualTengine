package utils;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.ui.Keyboard;
import Map;

/** Utility class for keyboard input. <strong>Requires that a KeyboardUtil object be initialized before the static members will be of any use.</strong> */
class KeyboardUtil{
	
	/** Currently pressed keys */
	private static var pressedKeys:Map<Int,String> = new Map<Int,String>();
	/** Keys pressed last frame */
	private static var justPressedKeys:Map<Int,String> = new Map<Int,String>();
	/** Keys released last frame */
	private static var justReleasedKeys:Map<Int,String> = new Map<Int,String>();
	/** Last key released */
    private static var lastKeyUp:Dynamic;
	
	/** Access strings using flash key codes <em>(Only WASD, arrows, and space because I'm too lazy to do the rest)</em> */
	public static var keyCodes:Map < Int, String > = [
	37 => "LEFT", 38 => "UP", 39 => "RIGHT", 40 => "DOWN",
	83 => "S", 68 => "D", 65 => "A", 87 => "W",
	32 => "SPACE"];
	/** Access flash key codes using strings <em>(Only WASD, arrows, and space because I'm too lazy to do the rest)</em> */
	public static var keyStrings:Map < String, Int > = [
	"LEFT" => 37, "UP" => 38, "RIGHT" => 39, "DOWN" => 40,
	"S" => 83, "D" => 68, "A" => 65, "W" => 87,
	"SPACE" => 32];
	
	/** Attaches event listeners so that the static stuff actually works. */
	public function new(){
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyboardUtil.key_Down);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, KeyboardUtil.key_Up);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, KeyboardUtil.clear_Just);
	}
	
	/** Adds a pressed key to the map of pressedKeys and justPressedKeys. */
	private static function key_Down(evt:KeyboardEvent) {
		if (!pressedKeys.exists(evt.keyCode)){
			pressedKeys.set(evt.keyCode, keyCodes.get(evt.keyCode));
			justPressedKeys.set(evt.keyCode, keyCodes.get(evt.keyCode));
		}
	}
	
	/** Removes and adds a pressed key from the map of pressedKeys and justReleasedKeys, respectively. */
	private static function key_Up(evt:KeyboardEvent){
		pressedKeys.remove(evt.keyCode);
		justReleasedKeys.set(evt.keyCode,keyCodes.get(evt.keyCode));
		lastKeyUp = keyCodes.get(evt.keyCode);
	}
	
	/** Clears justPressedKeys and justReleasedKeys on ENTER_FRAME. */
	public static function clear_Just(evt:Event){
		for (key in justPressedKeys.keys()) {
			justPressedKeys.remove(key);
		}
		for (key in justReleasedKeys.keys()) {
			justReleasedKeys.remove(key);
		}
	}
	
	/** Returns all keys currently pressed as a map. */
	public static function getPressedKeys():Map<Int,String> {
		return pressedKeys;
	}
	
	/** Returns all keys pressed in the last frame as a map. */
	public static function getJustPressedKeys():Map<Int,String> {
		return justPressedKeys;
	}
	
	/** Returns all keys released in the last frame as a map. */
	public static function getJustReleasedKeys():Map<Int,String> {
		return justReleasedKeys;
	}

	/**  Returns the last key released. */
    public static function getLastKeyUp():Dynamic{
        return lastKeyUp;
    }
	
	
	
	
	
	/**
	 * If any of the keys in the given array are pressed, returns true. Otherwise, returns false.
	 * @param	args An array of strings representing keys. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args are currently pressed, otherwise false.
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
	 * @return	Bool true if any of the args were just pressed, otherwise false.
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
	 * @return	Bool true if any of the args were just released, otherwise false.
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