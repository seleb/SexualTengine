package utils;
import flash.geom.Rectangle;

/**
 * ...
 * @author Sean
 */
class ST_Collision{

	public function new(){
		
	}
	
	public static function checkCollision(obj1:ST_Sprite, obj2:ST_Sprite):Bool {
		var collision:Bool = false;
		var rect1:Rectangle = new Rectangle(obj1.x, obj1.y, obj1.width, obj1.height);
		var rect2:Rectangle = new Rectangle(obj2.x, obj2.y, obj2.width, obj2.height);
		
		var collRect:Rectangle = rect1.intersection(rect2);
		if (collRect.width == 0 && collRect.height == 0) {
		}else {
			for (x in Math.round(collRect.x)...Math.round(collRect.x + collRect.width)) {
				for (y in Math.round(collRect.y)...Math.round(collRect.y + collRect.height)) {
					if(x == 1 && y == 1){
						//var p1:PixelArray = new PixelArray(obj1.getBitmap(),collRect);
						//var p2:PixelArray = new PixelArray(obj2.getBitmap(),collRect);
						
						var a1 = obj1.getBitmap().bitmapData.getPixel32(x, y);
						var a2 = obj2.getBitmap().bitmapData.getPixel32(x, y);
						trace(a1);
					}
					/*if (a1 > 0 && a2 > 0) {
						collision = true;
					}*/
				}
			}
		}
		
		return collision;
	}
}