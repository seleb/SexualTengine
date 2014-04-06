package utils;

/**
 * ...
 * @author ryan
 */
class ST_Logger
{
	/**
	 * Used to log a single variable. Better to use this than
	 * trace becasue it will only trace out the log if you are compiling 
	 * in debug mode
	 * 
	 * @param	log The variable to be logged 
	 */
	public static function Log(log:Dynamic) {
		#if debug
		trace(log);
		#end
	}
	
	/**
	 * Used to log multiple variables. Better to use this than 
	 * trace because it will only trace out the log if you are compiling in 
	 * debug mode. <strong>Tip -- You can declare an array like so [1, "string", sprite]</strong>
	 * 
	 * @param	logs A dynamic array of type dynamic. Holds the items to be logged 
	 * @param	?commaSeperated Whether the values should be comma seperated or not
	 */
	public static function LogMultiple(logs:Array<Dynamic>, ?commaSeperated:Bool = false) {
		#if debug
		var logString:String = "";
		var firstRun:Bool = true;
		for (log in logs) {
			if(commaSeperated)
				logString += firstRun ? Std.string(log) : (", " + Std.string(log));
			else
				logString += firstRun ? Std.string(log) : (" " + Std.string(log));
			firstRun = false;
		}
		trace(logString);
		#end
	}
}