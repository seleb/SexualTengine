package utils;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.utils.ByteArray;

/**
 * ...
 * @author Sean
 */
class PixelArray{
	public var pixels:Array<Pixel>;
	public function new(bitmap:Bitmap,rect:Rectangle){
		var _pixels:ByteArray = bitmap.bitmapData.getPixels(rect);
		
		pixels = new Array();
		var i = 0;
		var x = 0;
		var y = 0;
		while (i < _pixels.length) {
			pixels.insert(Math.round(i/4),new Pixel(_pixels[i + 1], _pixels[i + 2], _pixels[i + 3], _pixels[i]));
			
			i += 4;
			x += 1;
			if (x > bitmap.width) {
				x = 0;
				y += 1;
				if (y > bitmap.height) {
					y = 0;
				}
			}
		}
	}
	
}