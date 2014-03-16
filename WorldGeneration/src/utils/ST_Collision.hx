package utils;
import flash.geom.Rectangle;
/**
 * ...
 * @author Sean
 */
class ST_Collision{

	public function new(){
		
	}
	
	public static function checkCollision(obj1:ST_Sprite, obj2:ST_Sprite, threshold:Int = 0):Bool {
		var collision:Bool = false;
		var rect1:Rectangle = new Rectangle(obj1.x, obj1.y, obj1.width, obj1.height);
		var rect2:Rectangle = new Rectangle(obj2.x, obj2.y, obj2.width, obj2.height);
		
		var collRect:Rectangle = rect1.intersection(rect2);
		if (collRect.width == 0 && collRect.height == 0) {
		}else {
			for (x in 0 ... Math.round(collRect.width)) {
				for (y in 0 ... Math.round(collRect.height)) {
					var bx = Math.round(x + collRect.x - obj1.x);
					var by = Math.round(y + collRect.y - obj1.y);
					var a1:UInt = obj1.getBitmap().bitmapData.getPixel32(bx, by);
					bx = Math.round(x + collRect.x - obj2.x);
					by = Math.round(y + collRect.y - obj2.y);
					var a2:UInt = obj2.getBitmap().bitmapData.getPixel32(bx, by);
					
					//trace(x,y,StringTools.hex(a1),StringTools.hex(a2));
					//trace(StringTools.hex(a1 ),StringTools.hex(a2 ));
					//trace(StringTools.hex(a1 >> 8),StringTools.hex(a2 >> 8));
					//trace(StringTools.hex(a1 >> 16),StringTools.hex(a2 >>16));
					//trace(StringTools.hex(a1 >> 24), StringTools.hex(a2 >> 24));
					//trace(a1 >> 24 & 0xFF, a2 >> 24 & 0xFF);
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