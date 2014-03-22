package animation;

import flash.geom.Rectangle;

/**
 * ...
 * @author Ryan
 */
class ST_SpriteSheetHandler
{
	public function new(){}
	
	/** No docs yet */
	public static function getSpriteArrayByRange(imgWidth:Int, imgHeight:Int, spriteWidth:Int, spriteHeight:Int, startXCoord:Int, startYCoord:Int, endXCoord, endYCoord):Array<Rectangle>
	{
			var spritesX:Int;
			var spritesY:Int = cast(Math.round(imgHeight / spriteHeight),Int);
			var rectArray:Array<Rectangle> = new Array<Rectangle> ();
			var currentX:Float = startXCoord;
			var currentY:Float = startYCoord;
			
			if (endXCoord < cast(imgWidth / spriteWidth, Int)){
				spritesX = endXCoord;
			}
			else{
				spritesX = cast(imgWidth / spriteWidth, Int); 
			}
			for (i in 0...(spritesX * spritesY))
			{
				if (currentX >= endXCoord && currentY>=endYCoord){
					break;
				}
				if (currentX < spritesX){
					rectArray.push(new Rectangle((currentX* spriteWidth) ,(currentY * spriteHeight),(spriteWidth),(spriteHeight)));
					currentX++;
					
				}
				else {
					currentX = 0; 
					currentY++;
					rectArray.push(new Rectangle((currentX * spriteWidth) , (currentY * spriteHeight), (spriteWidth), (spriteHeight)));
					currentX++;
				}
			}
		return rectArray;		
	}
	
	/**
	 * This method is used to get a set of specific frames from a sprite sheet. It returns an array of rectangles to be used with ST_SpriteSheet
	 * 
	 * @param	_imgWidth		The width of the spritsheet
	 * @param	_imgHeight		The height of the spritesheet
	 * @param	_spriteHeight	The height of one sprite from the spritesheet
	 * @param	_spriteWidth	The width of one sprite from the spirtesheet
	 * @param	_frames			The id's of the sprites to be returned. These increase going across the image
	 * @return	An array of rectangles used to identify the drawable area for each frame
	 */
	public static function getSpriteArray(_imgWidth:Int, _imgHeight:Int, _spriteWidth:Int, _spriteHeight:Int, _frames:Array<Int>):Array<Rectangle>
	{
		var returnArray:Array<Rectangle> = new Array();
		
		/*
		 *  If the i * the sprite width is greater than the image width then subtract the image width
		 * 	from i * _spriteWidth so that it is basically starting at 0 for each new row.
		 * 	The y value is equal to the floor of i * the sprite width / image width. This way we know which
		 *  row we are on in the sprite sheet.
		 */
		for (i in _frames){
			returnArray.push(new Rectangle(
			(i*_spriteWidth) >= ((Math.floor(_imgWidth/_spriteWidth))*_spriteWidth) ? ((i * _spriteWidth) - (Math.floor(_imgWidth/_spriteWidth))*_spriteWidth) : (i * _spriteWidth),
			((_spriteHeight) * Math.floor(i * _spriteWidth / _imgWidth)), 
			_spriteWidth, 
			_spriteHeight));
		}
		
		return returnArray;
	}
	
}