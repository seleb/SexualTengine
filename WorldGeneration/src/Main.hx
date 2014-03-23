package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

import input.ST_GamepadManager;
import input.ST_Keyboard;
import input.ST_Mouse;

/**
 * ...
 * @author Sean
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
		var playState:PlayState;
	function init(){
		if (inited) {
			return;
		}
		
		// (initialization code here)
		stage.addEventListener(Event.ENTER_FRAME, gameLoop);
		addChild(playState = new PlayState());
		
		//inputs
		new ST_Keyboard();
		new ST_Mouse();
		new ST_GamepadManager();
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		inited = true;
	}

	function gameLoop(event:Dynamic) {
		playState.update();
		playState.draw();
	}
	
	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
