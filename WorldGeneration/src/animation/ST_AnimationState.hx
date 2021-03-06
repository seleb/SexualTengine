package animation;

/**
 * ...
 * @author Ryan
 */

import flash.display.*;
import flash.events.*;

class ST_AnimationState{
	public var frames:Array<Int>;
	private var currentFrame:Int;
	public var frameRate:Int;
	private var frameCounter:Int;

	/** No docs yet */
	public function new(framePass:Array<Int>, frameRatePass:Int) 
	{
		frames = framePass;
		frameRate = frameRatePass;
		currentFrame = 0;
		frameCounter = 0;
	}
	
	/** No docs yet */
	public function getCurrentFrame(){
		return frames[currentFrame];
	}
	public function incrementFrames(){
		frameCounter++;
		if (frameCounter >= frameRate){
			frameCounter = 0;
			currentFrame++;
			if (currentFrame >= frames.length ){
				currentFrame = 0;
			}
		}
	}
	
	/** No docs yet */
	public function setCurrentFrame(_frame:Int) {
		currentFrame = _frame;
		frameCounter = 0;
	}
	
}