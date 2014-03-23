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
		play = true;
	}
	
	/** No docs yet */
	public function addSpitesheet(_bitmapPath:String, _name:String, ?_setAsCurrent:Bool = false) {
		spriteSheets.set(_name, new ST_SpriteSheet(_bitmapPath));
		if (_setAsCurrent) {
			currentSpriteSheet = spriteSheets.get(_name);
		}
	}
	
	/** No docs yet */
	public function setCurrentSpriteSheet(_name:String) {
		currentSpriteSheet = spriteSheets.get(_name);
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
	
	/** Changes the animation state. <em>The current animation stays at the current frame.</em> */
	public function setAnimationState(_stateName:String) {
		if (currentSpriteSheet.animationStates.exists(_stateName)){
			currentSpriteSheet.currentState = currentSpriteSheet.animationStates.get(_stateName); 
		}else{
			trace("Animation state '"+_stateName + "' does not exist");
		}
	}
	
	/** 
	 * This method is used to draw the frame from the current sprite sheet's current animation state.
	 * Each time we call draw we clear the graphics (otherwise the sprites will just be added on top).
	 */
	public function draw()
	{
		if(play){
			var data=[0.0, 0.0, currentSpriteSheet.currentState.getCurrentFrame()];
			graphics.clear();
			currentSpriteSheet.drawTiles(graphics, data, true);
		}
	}
	
	/** 
	 * Pauses the current animation state at the given frame
	 * 
	 * @Param _frame The frame to pause at - 0 based
	 */
	public function pauseAt(_frame:Int) {
		currentSpriteSheet.currentState.setCurrentFrame(_frame);
		draw(); 
		play = false;
	}
	
	/** Pauses the animation manager, preventing frame updates */
	public function pauseAnimation() {
		play = false;
	}
	
	/** Sets the animation manager to play, causing frame updates to occur */
	public function playAnimation() {
		play = true;
	}
	
	/** 
	 * Plays the current animation state at the given frame
	 * 
	 * @Param _frame The frame to pause at - 0 based
	 */
	public function playFrom(_frame:Int) {
		play = true;
		currentSpriteSheet.currentState.setCurrentFrame(_frame);
	}
	
	/** Selects a sprite sheet and animation state, Sets these to the current sprite sheet and 
	 * animation state and plays from the specified frame.
	 * 
	 * @param _spriteSheetName The name of the spriteSheet to play from
	 * @param _stateName The name of the animation state to play from the specifyed sprite sheet
	 * @param _frame The frame to play the animation state from
	 */
	public function playStateFrom(_spriteSheetName:String, _stateName:String, _frame:Int) {
		play = true;
		currentSpriteSheet = spriteSheets.get(_spriteSheetName);
		currentSpriteSheet.currentState = currentSpriteSheet.animationStates.get(_stateName);
		currentSpriteSheet.currentState.setCurrentFrame(_frame);
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
	
	/** Sets the current animation state to the given frame
	 * @param	_frame	Frame to set to  - 0 based
	 */
	public function setCurrentFrame(_frame:Int) {
		currentSpriteSheet.currentState.setCurrentFrame(_frame);
	}
	
	/** Resets the current animation state to frame 0 (argument doesn't do anything yet) */
	public function reset(name:String) {
		currentSpriteSheet.currentState.setCurrentFrame(0);
	}
	
	/** No docs yet */
	public function setFrameRate(_frameRate:Int) {
		currentSpriteSheet.currentState.frameRate = _frameRate;
	}
	
	/** No docs yet */
	public function setFrameRateForState(_spriteSheetName:String, _stateName:String, _frameRate:Int) {
		spriteSheets.get(_spriteSheetName).animationStates.get(_stateName).frameRate = _frameRate;
	}
}