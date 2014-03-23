package input;
import flash.events.Event;
import flash.Lib;
import openfl.events.JoystickEvent;

/** Class for instantiating individual gamepad objects */
class ST_Gamepad {
	/** Currently pressed buttons */
	public var pressedButtons:Map<Int,Int>;
	/** Buttons pressed last frame */
	public var justPressedButtons:Map<Int,Int>;
	/** Buttons released last frame */
	public var justReleasedButtons:Map<Int,Int>;
	/** Last button released */
    public var lastButtonUp:Int;
	/** Array of axis positions */
	public var axes:Array<Float>;
	public var hat:Array<Float>;
	/** Controller id */
	public var device:Int;

	
	public function new(device:Int){
		pressedButtons = new Map<Int,Int>();
		justPressedButtons = new Map<Int,Int>();
		justReleasedButtons = new Map<Int,Int>();
		axes = new Array<Float>();
		hat = new Array<Float>();
		this.device = device;
	}
}

/** Class for handling gamepads. <strong>Requires that a GamepadManager object be initialized before the static members will be of any use.</strong> */
class ST_GamepadManager{
	public static var numPads:Int = 0;
	/** Array of gamepads */
	public static var pads:Map<Int,ST_Gamepad> = new Map<Int,ST_Gamepad>();
	
	/** Currently pressed Buttons */
	private static var pressedButtons:Map<Int,String> = new Map<Int,String>();
	/** Buttons pressed last frame */
	private static var justpressedButtons:Map<Int,String> = new Map<Int,String>();
	/** Buttons released last frame */
	private static var justReleasedButtons:Map<Int,String> = new Map<Int,String>();
	
	public function new(){
		Lib.current.stage.addEventListener(JoystickEvent.BUTTON_DOWN, ST_GamepadManager.buttonDown);
		Lib.current.stage.addEventListener(JoystickEvent.BUTTON_UP, ST_GamepadManager.buttonUp);
		Lib.current.stage.addEventListener(JoystickEvent.AXIS_MOVE, ST_GamepadManager.axisMove);
		Lib.current.stage.addEventListener(JoystickEvent.HAT_MOVE, ST_GamepadManager.hatMove);
		Lib.current.stage.addEventListener(JoystickEvent.BALL_MOVE, ST_GamepadManager.ballMove);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, ST_GamepadManager.clearJust);
	}
	private static function buttonDown(evt:JoystickEvent) {
		if (!pads.get(evt.device).pressedButtons.exists(evt.id)){
			pads.get(evt.device).pressedButtons.set(evt.id, evt.id);
			pads.get(evt.device).justPressedButtons.set(evt.id, evt.id);
		}
	}
	private static function buttonUp(evt:JoystickEvent){
		pads.get(evt.device).pressedButtons.remove(evt.id);
		pads.get(evt.device).justReleasedButtons.set(evt.id,evt.id);
		pads.get(evt.device).lastButtonUp = evt.id;
	}
	private static function axisMove(evt:JoystickEvent) {
		pads.get(evt.device).axes = evt.axis;
	}
	private static function hatMove(evt:JoystickEvent) {
		pads.get(evt.device).hat = evt.axis;
	}
	private static function ballMove(evt:JoystickEvent) {
		//I don't actually know what this event covers, apparently nothing on an xbox controller
	}
	
	/** Clears justPressedButtons and justReleasedButtons on ENTER_FRAME. */
	public static function clearJust(evt:Event) {
		for(pad in pads){
			for (button in pad.justPressedButtons) {
				pad.justPressedButtons.remove(button);
			}
			for (button in pad.justReleasedButtons) {
				pad.justReleasedButtons.remove(button);
			}
		}
	}
	
	
	
	/** Adds a gamepad to the pads array 
	 * @param	device	Controller id, <em>Defaults to ST_GamepadManager.numPads</em>*/
	public static function addController(device:Int) {
		if (!pads.exists(device)) {
			pads.set(device, new ST_Gamepad(device));
			numPads += 1;
		}else {
			trace("ERROR: Gamepad device '" + device + "' already exists");
		}
	}
	
	/**
	 * If any of the buttons in the given array are pressed, returns true. Otherwise, returns false.
	 * @param	device	Controller id
	 * @param	args	An array of strings representing buttons. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args are currently pressed, false otherwise.
	*/
	public static function isPressed(device:Int, args:Array<String>):Bool {
		var i:String;
		var res:Bool = false;
		while (args.length != 0) {
			i = args.pop();
			if (pads.get(device).pressedButtons.exists(XboxButtons.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * If any of the buttons in the given array was pressed in the last frame, returns true. Otherwise, returns false.
	 * @param	device	Controller id
	 * @param	args An array of strings representing buttons. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args were just pressed, false otherwise.
	*/
	public static function isJustPressed(device:Int, args:Array<String>):Bool {
		var i:String;
		var res:Bool = false;
		while (args.length != 0) {
			i = args.pop();
			if (pads.get(device).justPressedButtons.exists(XboxButtons.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * If any of the buttons in the given array was released in the last frame, returns true. Otherwise, returns false.
	 * @param	device	Controller id
	 * @param	args An array of strings representing buttons. <em>Remember that even individual key checks need array notation: [""].</em>
	 * @return	Bool true if any of the args were just released, false otherwise.
	*/
	public static function isJustReleased(device:Int, args:Array<String>):Bool {
		var i:String;
		var res:Bool = false;
		while (args.length != 0) {
			i = args.pop();
			if (pads.get(device).justReleasedButtons.exists(XboxButtons.get(i))) {
				res = true;
			}
		}
		return res;
	}
	
	/**
	 * Compares a given axis on a device to a given threshold
	 * @param	device		Controller id
	 * @param	axis		Key for axis array. <em>Use the shortcuts in the XboxAxes for this.</em>
	 * @param	threshold	Threshold to check axis against. Values 0 to 1.
	 * @return	True if axis is below the given thershold for the device, false otherwise
	 */
	public static function axisIsBelow(device:Int, axis:String, threshold:Float):Bool{
		return pads.get(device).axes[XboxAxes[axis]] < threshold;
	}
	/**
	 * Compares a given axis on a device to a given threshold
	 * @param	device		Controller id
	 * @param	axis		Key for axis array. <em>Use the shortcuts in the XboxAxes for this.</em>
	 * @param	threshold	Threshold to check axis against. Values 0 to 1.
	 * @return	True if axis is above the given thershold for the device, false otherwise
	 */
	public static function axisIsAbove(device:Int, axis:String, threshold:Float):Bool{
		return pads.get(device).axes[XboxAxes[axis]] > threshold;
	}
	/**
	 * Compares a hat on a device to a given threshold
	 * @param	device		Controller id
	 * @param	axis		Key for hat array. <em>Use the shortcuts in the XboxHat for this.</em>
	 * @param	threshold	Threshold to check hat against. Values 0 to 1.
	 * @return	True if hat is below the given thershold for the device, false otherwise
	 */
	public static function hatIsBelow(device:Int, axis:String, threshold:Float):Bool{
		return pads.get(device).hat[XboxHat[axis]] < threshold;
	}
	/**
	 * Compares a hat on a device to a given threshold
	 * @param	device		Controller id
	 * @param	axis		Key for hat array. <em>Use the shortcuts in the XboxHat for this.</em>
	 * @param	threshold	Threshold to check hat against. Values 0 to 1.
	 * @return	True if hat is above the given thershold for the device, false otherwise
	 */
	public static function hatIsAbove(device:Int, axis:String, threshold:Float):Bool{
		return pads.get(device).hat[XboxHat[axis]] > threshold;
	}
	
	
	/** Contains A, B, X, Y, L1, R1, SELECT, START, L3, R3. <em>L3 and R3 are when you press on the sticks.</em>*/
	public static var XboxButtons:Map<String, Int> = [
		"A"			=>	0,
		"B"			=>	1,
		"X"			=>	2,
		"Y"			=>	3,
		"L1"		=>	4,
		"R1"		=>	5,
		"SELECT"	=>	6,
		"START"		=>	7,
		"L3"		=>	8,
		"R3"		=>	9];
	/** Contains LX, LY, RX, RY, TRIGGERS. */
	public static var XboxAxes:Map<String, Int> = [
		"LX"		=>	0,
		"LY"		=>	1,
		"RX"		=>	4,
		"RY"		=>	3,
		"TRIGGERS"	=>	2];
	/** Contains X, Y. <em>The hat is the d-pad.</em> */
	public static var XboxHat:Map<String, Int> = [
		"X"		=>	0,
		"Y"		=>	1];
}