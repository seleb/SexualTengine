package ;

import camera.ST_Camera;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.Lib;

import input.ST_Mouse;
import input.ST_Keyboard;
import input.ST_GamepadManager;
import input.ST_GeneralInput;
import input.ST_TouchManager;

import utils.ST_Collision;

class PlayState extends Sprite{
	public var playing = true;
	private var player:ST_Sprite;
	private var terrain:ST_Sprite;
	private static var camera:ST_Camera;
	
	private var sprites:Array<ST_Sprite>;
	
	public function new() {
		super();
		
		#if !flash
		ST_GamepadManager.addController(0);
		#end
		
		player = new ST_Sprite();
		//player.setBitmap("img/playerHead.png");
		player.animation.addSpriteSheet("img/spritesheet.png", "main", true);
		player.animation.addAnimationState("main", "down",	[0,1,2,3,4,5,6,7], 5, 51, 70);
		player.animation.addAnimationState("main", "left",	[8,10,11,9,12,13,14,15], 5, 51, 70);
		player.animation.addAnimationState("main", "right",	[16,18,19,17,20,21,22,23], 5, 51, 70);
		player.animation.addAnimationState("main", "up",	[24, 25, 26, 27, 28, 29, 30, 31], 5, 51, 70);
		player.animation.playAnimation(0, "left", "main");
		
		terrain = new ST_Sprite();
		terrain.setBitmap("img/terrain.png");
		
		addChild(terrain);
		addChild(player);
		
		sprites = new Array<ST_Sprite>();
		sprites.push(player);
		sprites.push(terrain);
		
		camera = new ST_Camera(0, 0, 800, 480, 250, 200);
		camera.follow(player);
		
	}
	
	public function update() {
		//movement
		player.movement.resetAcceleration();
		if(ST_GeneralInput.down(0)){
			//player.movement.acceleration.y = 2;
			player.movement.applyForce(new Point(0,2));
			player.animation.playAnimation(null,"down");
		}if(ST_GeneralInput.left(0)){
			//player.movement.acceleration.x = -2;
			player.movement.applyForce(new Point(-2,0));
			player.animation.playAnimation(null,"left");
		}if (ST_GeneralInput.right(0)){
			//player.movement.acceleration.x = 2;
			player.movement.applyForce(new Point(2,0));
			player.animation.playAnimation(null,"right");
		}if (ST_GeneralInput.up(0)){
			//player.movement.acceleration.y = -2;
			player.movement.applyForce(new Point(0,-2));
			player.animation.playAnimation(null,"up");
		}
		player.update();
		//framerate
		if (ST_GeneralInput.primary(0,true)) {
			player.animation.setFrameRate(player.animation.getFrameRate()+1);
		}	
		if (ST_GeneralInput.secondary(0,true)) {
			player.animation.setFrameRate(player.animation.getFrameRate()-1);
		}
	
		//scrollRect = new Rectangle(player.x, player.y, 640, 480);
		scrollRect = camera.getFrame();
		
		//collision
		//if (ST_Keyboard.isJustPressed(["SPACE"])) {
		//	trace(ST_Collision.checkCollision(player, terrain, 200));
		//}
		//trace(ST_TouchManager.touches);
		//trace(player.animation.getLargestBoundForStateByWidth("main", "test"));
	}
	
	public function draw() {
		//call draw() on the animation manager for all ST_Sprites
		for (i in sprites) {
			i.animation.draw();
		}
	}
}