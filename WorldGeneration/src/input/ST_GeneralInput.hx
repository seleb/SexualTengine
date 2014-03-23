package input;

import input.ST_GamepadManager;
import input.ST_Mouse;
import input.ST_Keyboard;

/** Contains shortcut functions for covering input from multiple devices */
class ST_GeneralInput{
	public function new() { }
	
	/**
	 * Returns true if Keyboard ['S', 'DOWN'] is pressed or Gamepad ['LY', D-Pad 'Y'] > 0.5, false otherwise
	 * @param	device	Controller id
	 * @return	true if generalized input for down is active, false otherwise
	 */
	public static function down(device:Int):Bool{
		return ST_Keyboard.isPressed(["S", "DOWN"]) || ST_GamepadManager.axisIsAbove(device, "LY", 0.5) || ST_GamepadManager.hatIsAbove(device, "Y", 0.5);
	}
	
	/**
	 * Returns true if Keyboard ['W', 'UP'] is pressed or Gamepad ['LY', D-Pad 'Y'] < -0.5, false otherwise
	 * @param	device	Controller id
	 * @return	true if generalized input for up is active, false otherwise
	 */
	public static function up(device:Int):Bool{
		return ST_Keyboard.isPressed(["W", "UP"]) || ST_GamepadManager.axisIsBelow(device, "LY", -0.5) || ST_GamepadManager.hatIsBelow(device, "Y", -0.5);
	}
	
	/**
	 * Returns true if Keyboard ['A', 'LEFT'] is pressed or Gamepad ['LX', D-Pad 'X'] < -0.5, false otherwise
	 * @param	device	Controller id
	 * @return	true if generalized input for left is active, false otherwise
	 */
	public static function left(device:Int):Bool {
		return ST_Keyboard.isPressed(["A", "LEFT"]) || ST_GamepadManager.axisIsBelow(device, "LX", -0.5) || ST_GamepadManager.hatIsBelow(device, "X", -0.5);
	}
	
	/**
	 * Returns true if Keyboard ['D', 'RIGHT'] is pressed or Gamepad ['LX', D-Pad 'X'] > 0.5, false otherwise
	 * @param	device	Controller id
	 * @return	true if generalized input for right is active, false otherwise
	 */
	public static function right(device:Int):Bool{
		return ST_Keyboard.isPressed(["D", "RIGHT"]) || ST_GamepadManager.axisIsAbove(device, "LX", 0.5) || ST_GamepadManager.hatIsAbove(device, "X", 0.5);
	}
	
	
	
	/**
	 * Returns true if Keyboard 'Z', LMB, or Gamepad 'A' is pressed
	 * @param	device	Controller id
	 * @param	justOne	Whether to use isPressed (false) or isJustPressed (true)
	 * @return	true if generalized input for primary is active, false otherwise
	 */
	public static function primary(device:Int, justOne:Bool):Bool{
		if (justOne) {
			return ST_Keyboard.isJustPressed(["Z"]) || ST_GamepadManager.isJustPressed(0,["A"]) || ST_Mouse.leftJustPressed;
		}else {
			return ST_Keyboard.isPressed(["Z"]) || ST_GamepadManager.isPressed(0,["A"]) || ST_Mouse.leftPressed;
		}
	}
	/**
	 * Returns true if Keyboard 'X', RMB, or Gamepad 'B' is pressed
	 * @param	device	Controller id
	 * @param	justOne	Whether to use isPressed (false) or isJustPressed (true)
	 * @return	true if generalized input for secondary is active, false otherwise
	 */
	public static function secondary(device:Int, justOne:Bool):Bool {
		if(justOne){
			return ST_Keyboard.isJustPressed(["X"]) || ST_GamepadManager.isJustPressed(0, ["B"]) || ST_Mouse.rightJustPressed;
		}else {
			return ST_Keyboard.isPressed(["X"]) || ST_GamepadManager.isPressed(0, ["B"]) || ST_Mouse.rightPressed;
		}
	}
}