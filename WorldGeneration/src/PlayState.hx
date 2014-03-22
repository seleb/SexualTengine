package ;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import openfl.Assets;
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
		
		var keys:KeyboardUtil = new KeyboardUtil();
		
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
		if (KeyboardUtil.isPressed(["S","DOWN"])) {
			player.y += 1;
			player.animation.pauseAnimation();
		}if (KeyboardUtil.isPressed(["W","UP"])) {
			player.y -= 1;
			player.animation.playFrom(6);
		}if (KeyboardUtil.isPressed(["A","LEFT"])) {
			player.x -= 1;
			player.animation.playAnimation();
		}if (KeyboardUtil.isPressed(["D","RIGHT"])) {
			player.x += 1;
		}if (KeyboardUtil.isJustPressed(["SPACE"])) {
			trace(ST_Collision.checkCollision(player, terrain, 200));
		}
		
		player.animation.draw();
		trace(player.animation.getLargestBoundForStateByWidth("main", "test"));
	}
	
	public function draw() {
		/*for (i in 0...this.numChildren) {
			var child = this.getChildAt(i);
			
		}*/
	}
}