package animation;

/**
 * ...
 * @author Ryan
 */
 
import animation.ST_AnimationState;
import flash.display.*;
import flash.display.Bitmap;
import flash.events.*;
import flash.geom.Rectangle;
import openfl.Assets;
import openfl.display.Tilesheet;
import animation.ST_SpriteSheetHandler;
import flash.display.Graphics;
import animation.ST_SpriteSheet;
import openfl.gl.GLTexture;


class ST_AnimationManager{
	
	private var graphics:Graphics;
	private var currentSpriteSheet:ST_SpriteSheet;
	public var play:Bool;
	public  var spriteSheets:Map<String,ST_SpriteSheet>;
	
	/** No docs yet */
	public function new(_graphics:Graphics) {
		graphics = _graphics;
		spriteSheets = new Map();
		play = false;
	}
	
	/** No docs yet */
	public function addSpriteSheet(_bitmapPath:String, _name:String, ?_setAsCurrent:Bool = false):Void{
		spriteSheets.set(_name, new ST_SpriteSheet(_bitmapPath));
		if (_setAsCurrent) {
			currentSpriteSheet = spriteSheets.get(_name);
		}
	}
	
	/**
	 * Creates a new animation state
	 * @param	_spriteSheet	Name of spritesheet
	 * @param	_stateName		Name for new animation state
	 * @param	_frames			Array of frames, where the frames are read left-to-right, top-to-bottom from 0
	 * @param	_frameRate		Default framerate for new animation state
	 * @param	_frameWidth		Width of individual frames on the sprite sheet
	 * @param	_frameHeight	Height of individual frames on the sprite sheet
	 */
	public function addAnimationState(_spriteSheet:String, _stateName:String, _frames:Array<Int>, _frameRate:Int, _frameWidth:Int, _frameHeight:Int):Void{	
		spriteSheets.get(_spriteSheet).addAnimationState(_stateName, _frames, _frameRate, _frameWidth, _frameHeight);	
	}
	
	/**
	 * Switches the spritesheet.
	 * <em>The current animation stays at the current frame.</em>
	 * @param _spriteSheetName	The name of the spriteSheet to switch to
	 */
	public function setSpriteSheet(_spriteSheetName:String):Void{
		currentSpriteSheet = spriteSheets.get(_spriteSheetName);
	}
	
	/**
	 * Switches the animation state. Optionally specify host spritesheet to switch to as well.
	 * <em>The current animation stays at the current frame.</em>
	 * 
	 * @param _stateName		The name of the animation state to switch to
	 * @param ?_spriteSheetName	The name of the spriteSheet hosting the animation state (defaults to current)
	 */
	public function setAnimationState(_stateName:String, ?_spriteSheetName) {
		if (_spriteSheetName != null) {
			currentSpriteSheet = spriteSheets.get(_spriteSheetName);
		}
		currentSpriteSheet.currentState = currentSpriteSheet.animationStates.get(_stateName);
	}
	
	/** 
	 * This method is used to draw the frame from the current sprite sheet's current animation state.
	 * Each time we call draw we clear the graphics (otherwise the sprites will just be added on top).
	 */
	public function draw(){
		if(play){
			var data=[0.0, 0.0, currentSpriteSheet.currentState.getCurrentFrame()];
			graphics.clear();
			currentSpriteSheet.drawTiles(graphics, data, true);
		}
	}
	/**
	 * Sets the animation manager to pause, preventing frame updates to occur. Optionally specify frame to pause at, target state, and host spritesheet (will always switch to these if specified)
	 * 
	 * @param ?_frame			The frame to pause the animation state at - 0 based (defaults to current)
	 * @param ?_stateName		The name of the animation state to set (defaults to current, requires _frame)
	 * @param ?_spriteSheetName	The name of the spriteSheet hosting the animation state (defaults to current, requires _frame and _stateName)
	 */
	public function pauseAnimation(?_frame:Int, ?_stateName:String, ?_spriteSheetName:String) {
		if (_frame != null) {
			if (_stateName != null) {
				if (_spriteSheetName != null) {
					currentSpriteSheet = spriteSheets.get(_spriteSheetName);
				}
				currentSpriteSheet.currentState = currentSpriteSheet.animationStates.get(_stateName);
			}
			currentSpriteSheet.currentState.setCurrentFrame(_frame);
		}
		draw();
		play = false;
	}
	
	/**
	 * Sets the animation manager to play, causing frame updates to occur. Optionally specify start frame, target state, and host spritesheet
	 * 
	 * @param ?_frame			The frame to play the animation state from - 0 based (defaults to current)
	 * @param ?_stateName		The name of the animation state to set (defaults to current)
	 * @param ?_spriteSheetName	The name of the spriteSheet hosting the animation state (defaults to current)
	 */
	public function playAnimation(?_frame:Int, ?_stateName:String, ?_spriteSheetName:String) {
		if (_spriteSheetName != null) {
			currentSpriteSheet = spriteSheets.get(_spriteSheetName);
		}if (_stateName != null) {
			currentSpriteSheet.currentState = currentSpriteSheet.animationStates.get(_stateName);
		}if (_frame != null) {
			currentSpriteSheet.currentState.setCurrentFrame(_frame);
		}play = true;
	}
	
	/** No docs yet */
	public function getCurrentFrameBounds():Rectangle {
		return currentSpriteSheet.getTileRect(currentSpriteSheet.currentState.getCurrentFrame());
	}
	
	/** No docs yet */
	public function getLargestBoundForStateByWidth(_spiteSheetName:String,_name:String):Rectangle{
		var tempState:ST_AnimationState = spriteSheets.get(_spiteSheetName).animationStates.get(_name);
		var tempSpriteSheet:ST_SpriteSheet = spriteSheets.get(_spiteSheetName);
		var largest:Float = 0;
		var returnRect:Rectangle = new Rectangle(0,0,0,0);
		for (i in tempState.frames) {
			if (tempSpriteSheet.getTileRect(i).width > largest) {
				returnRect = tempSpriteSheet.getTileRect(i);
				largest = tempSpriteSheet.getTileRect(i).width;
			}
		}
		
		return returnRect;
	}
	
	/** No docs yet */
	public function getLargestBoundForStateByHeight(_spiteSheetName:String,_name:String):Rectangle{
		var tempState:ST_AnimationState = spriteSheets.get(_spiteSheetName).animationStates.get(_name);
		var tempSpriteSheet:ST_SpriteSheet = spriteSheets.get(_spiteSheetName);
		var largest:Float = 0;
		var returnRect:Rectangle= new Rectangle(0,0,0,0);
		for (i in tempState.frames) {
			if (tempSpriteSheet.getTileRect(i).height > largest) {
				returnRect = tempSpriteSheet.getTileRect(i);
				largest = tempSpriteSheet.getTileRect(i).height;
			}
		}
		
		return returnRect;
	}
	
	/** No docs yet */
	public function getLargestBoundForStateByArea(_spiteSheetName:String,_name:String):Rectangle{
		var tempState:ST_AnimationState = spriteSheets.get(_spiteSheetName).animationStates.get(_name);
		var tempSpriteSheet:ST_SpriteSheet = spriteSheets.get(_spiteSheetName);
		var largest:Float = 0;
		var returnRect:Rectangle= new Rectangle(0,0,0,0);
		for (i in tempState.frames) {
			if (tempSpriteSheet.getTileRect(i).width * tempSpriteSheet.getTileRect(i).height > largest) {
				returnRect = tempSpriteSheet.getTileRect(i);
				largest = tempSpriteSheet.getTileRect(i).width * tempSpriteSheet.getTileRect(i).height;
			}
		}
		
		return returnRect;
	}
	
	/** No docs yet */
	public function getSmallestBoundForStateByWidth(_spiteSheetName:String,_name:String):Rectangle{
		var tempState:ST_AnimationState = spriteSheets.get(_spiteSheetName).animationStates.get(_name);
		var tempSpriteSheet:ST_SpriteSheet = spriteSheets.get(_spiteSheetName);
		var smallest:Float = 0;
		var returnRect:Rectangle= new Rectangle(0,0,0,0);
		for (i in tempState.frames) {
			if (tempSpriteSheet.getTileRect(i).width > smallest) {
				returnRect = tempSpriteSheet.getTileRect(i);
				smallest = tempSpriteSheet.getTileRect(i).width;
			}
		}
		
		return returnRect;
	}
	
	/** No docs yet */
	public function getSmallestBoundForStateByHeight(_spiteSheetName:String,_name:String):Rectangle{
		var tempState:ST_AnimationState = spriteSheets.get(_spiteSheetName).animationStates.get(_name);
		var tempSpriteSheet:ST_SpriteSheet = spriteSheets.get(_spiteSheetName);
		var smallest:Float = 0;
		var returnRect:Rectangle= new Rectangle(0,0,0,0);
		for (i in tempState.frames) {
			if (tempSpriteSheet.getTileRect(i).height > smallest) {
				returnRect = tempSpriteSheet.getTileRect(i);
				smallest = tempSpriteSheet.getTileRect(i).height;
			}
		}
		
		return returnRect;
	}
	
	/** No docs yet */
	public function getSmallestBoundForStateByArea(_spiteSheetName:String,_name:String):Rectangle{
		var tempState:ST_AnimationState = spriteSheets.get(_spiteSheetName).animationStates.get(_name);
		var tempSpriteSheet:ST_SpriteSheet = spriteSheets.get(_spiteSheetName);
		var smallest:Float = 0;
		var returnRect:Rectangle= new Rectangle(0,0,0,0);
		for (i in tempState.frames) {
			if (tempSpriteSheet.getTileRect(i).width * tempSpriteSheet.getTileRect(i).height > smallest) {
				returnRect = tempSpriteSheet.getTileRect(i);
				smallest = tempSpriteSheet.getTileRect(i).width * tempSpriteSheet.getTileRect(i).height;
			}
		}
		
		return returnRect;
	}
	/**
	 * Sets the current animation state to the given frame. Optionally specify target state, and host spritesheet
	 * 
	 * @param _frame			The frame to set animation state to - 0 based
	 * @param ?_stateName		The name of the animation state to set (defaults to current)
	 * @param ?_spriteSheetName	The name of the spriteSheet hosting the animation state (defaults to current)
	 * @param _switchState		Whether to switch to the optional animation state/spritesheet
	 */
	public function setCurrentFrame(_frame:Int, ?_stateName:String, ?_spriteSheetName:String, _switchState:Bool = true) {
		if (_stateName != null) {
			if (_spriteSheetName != null) {
				if (_switchState) {
					currentSpriteSheet = spriteSheets.get(_spriteSheetName);
				}else {
					spriteSheets.get(_spriteSheetName).animationStates.get(_stateName).setCurrentFrame(_frame);
					return;
				}
			}
			if(_switchState){
				currentSpriteSheet.currentState = currentSpriteSheet.animationStates.get(_stateName);
			}else {
				currentSpriteSheet.animationStates.get(_stateName).setCurrentFrame(_frame);
				return;
			}
		}
		currentSpriteSheet.currentState.setCurrentFrame(_frame);
	}
	/** Resets the current animation state to frame 0
	 * <em>As far as I can tell this method is redundant (same as setCurrentFrame(0), but maybe it's supposed to do something else?</em>
	 * @param name	Doesn't do anything*/
	public function reset(name:String):Void{
		currentSpriteSheet.currentState.setCurrentFrame(0);
	}
	
	/**
	 * Sets the animation manager framerate for current state. Optionally specify target state and host spritesheet
	 * @param _frameRate		The target framerate
	 * @param ?_stateName		The name of the animation state to set (defaults to current)
	 * @param ?_spriteSheetName	The name of the spriteSheet hosting the animation state (defaults to current)
	 * @param _switchState		Whether to switch to the optional animation state/spritesheet
	 * 
	 */
	public function setFrameRate(_frameRate:Int, ?_stateName:String, ?_spriteSheetName:String, _switchState:Bool = true):Void {
		if (_stateName != null) {
			if (_spriteSheetName != null) {
				if (_switchState) {
					currentSpriteSheet = spriteSheets.get(_spriteSheetName);
				}else {
					spriteSheets.get(_spriteSheetName).animationStates.get(_stateName).frameRate = _frameRate;
					return; //
				}
			}
			if (_switchState) {
				currentSpriteSheet.currentState = currentSpriteSheet.animationStates.get(_stateName);
			}else {
				currentSpriteSheet.animationStates.get(_stateName).frameRate = _frameRate;
				return;
			}
		}
		currentSpriteSheet.currentState.frameRate = _frameRate;
	}
	
	/**
	 * Returns framerate for current state. Optionally specify target state and host spritesheet
	 * @param	?_stateName			The name of the animation state to get (defaults to current)
	 * @param	?_spriteSheetName	The name of the spriteSheet hosting the animation state (defaults to current)
	 * @return	Framerate
	 */
	public function getFrameRate(?_stateName:String, ?_spriteSheetName:String):Int {
		if (_spriteSheetName == null) {
			if (_stateName == null) {
				return currentSpriteSheet.currentState.frameRate;
			}
			return currentSpriteSheet.animationStates[_stateName].frameRate;
		}
		return spriteSheets[_spriteSheetName].animationStates[_stateName].frameRate;
	}
}