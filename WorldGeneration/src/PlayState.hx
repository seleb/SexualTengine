package ;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import openfl.Assets;
import utils.ST_GamepadManager;
import utils.KeyboardUtil;
import utils.PixelArray;

import utils.Pixel;
import utils.ST_Collision;

class PlayState extends Sprite{
	public var playing = true;
	private var player:ST_Sprite;
	private var terrain:ST_Sprite;
	
	
	public function new() {
		super();
		
		var keyboardUtil:KeyboardUtil = new KeyboardUtil();
		var gamepadManager:ST_GamepadManager = new ST_GamepadManager();
		ST_GamepadManager.addController(0);
		
		player = new ST_Sprite();
		player.setBitmap("img/playerHead.png");
		player.animation.addSpitesheet("img/spritesheet.png", "main", true);
		player.animation.addAnimationState("main", "test", [0,1,2,3,4,5,6,7], 5, 51, 70);
		player.animation.playStateFrom("main", "test", 0);
		
		terrain = new ST_Sprite();
		terrain.setBitmap("img/terrain.png");
		addChild(terrain);
		addChild(player);
	}
	
	public function update() {
		//movement
		if (KeyboardUtil.isPressed(["S","DOWN"]) || ST_GamepadManager.axisIsAbove(0,"LY",0.5)) {
			player.y += 1;
			player.animation.pauseAnimation();
		}if (KeyboardUtil.isPressed(["W","UP"]) || ST_GamepadManager.axisIsBelow(0,"LY",-0.5)) {
			player.y -= 1;
			player.animation.playFrom(6);
		}if (KeyboardUtil.isPressed(["A","LEFT"]) || ST_GamepadManager.axisIsBelow(0,"LX",-0.5)) {
			player.x -= 1;
			player.animation.playAnimation();
		}if (KeyboardUtil.isPressed(["D","RIGHT"]) || ST_GamepadManager.axisIsAbove(0,"LX",0.5)) {
			player.x += 1;
		}
		
		//framerate
		if (ST_GamepadManager.isPressed(0, ["A"])) {
			player.animation.setFrameRate(2);
		}if (ST_GamepadManager.isPressed(0, ["X"])) {
			player.animation.setFrameRate(4);
		}if (ST_GamepadManager.isPressed(0, ["Y"])) {
			player.animation.setFrameRate(8);
		}if (ST_GamepadManager.isPressed(0, ["B"])) {
			player.animation.setFrameRate(16);
		}
		
		//collision
		if (KeyboardUtil.isJustPressed(["SPACE"])) {
			trace(ST_Collision.checkCollision(player, terrain, 200));
		}
		
		player.animation.draw();
		//trace(player.animation.getLargestBoundForStateByWidth("main", "test"));
	}
	
	public function draw() {
		/*for (i in 0...this.numChildren) {
			var child = this.getChildAt(i);
			
		}*/
	}
}