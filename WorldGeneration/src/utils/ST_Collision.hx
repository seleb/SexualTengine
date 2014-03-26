package utils;
import flash.geom.Point;
import flash.geom.Rectangle;

import animation.ST_SpriteSheetHandler;
/**
 * ...
 * @author Sean
 */
class ST_Collision{

	public function new(){
		
	}
	
	public static function checkCollision(obj1:ST_Sprite, obj2:ST_Sprite, threshold:Int = 0):Bool {
		var spriteSheetOffset1:Point = new Point();
		var spriteSheetOffset2:Point = new Point();
		if (obj1.animation.getSpriteSheet() != null) {
			spriteSheetOffset1 = obj1.animation.getXY();
		}if (obj2.animation.getSpriteSheet() != null) {
			spriteSheetOffset2 = obj2.animation.getXY();
		}
		var collision:Bool = false;
		var rect1:Rectangle = new Rectangle(obj1.x, obj1.y, obj1.width, obj1.height);
		var rect2:Rectangle = new Rectangle(obj2.x, obj2.y, obj2.width, obj2.height);
		
		var collRect:Rectangle = rect1.intersection(rect2);
		if (collRect.width == 0 && collRect.height == 0) {
		}else {
			for (x in 0 ... Math.round(collRect.width)) {
				for (y in 0 ... Math.round(collRect.height)) {
					var bx = Math.round(x + collRect.x - obj1.x+spriteSheetOffset1.x);
					var by = Math.round(y + collRect.y - obj1.y+spriteSheetOffset1.y);
					
					var a1:Int;
					if (obj1.animation.getSpriteSheet() != null) {
						a1 = obj1.animation.getBitmapData().getPixel32(bx, by);
					}else {
						a1 = obj1.getBitmap().bitmapData.getPixel32(bx, by);
					}
					
					bx = Math.round(x + collRect.x - obj2.x+spriteSheetOffset2.x);
					by = Math.round(y + collRect.y - obj2.y+spriteSheetOffset2.y);
					
					var a2:Int;
					if (obj2.animation.getSpriteSheet() != null) {
						a2 = obj2.animation.getBitmapData().getPixel32(bx, by);
					}else {
						a2 = obj2.getBitmap().bitmapData.getPixel32(bx, by);
					}
					
					if ((a1 >> 24 & 0xFF) > threshold && (a2 >> 24 & 0xFF) > threshold) {
						collision = true;
						
						break;
					}
				}
				if(collision){
					break;
				}
			}
		}
		
		return collision;
	}
}