package animation;

import flash.geom.Rectangle;
import openfl.Assets;
import openfl.display.Tilesheet;
import flash.display.Bitmap;

/**
 * ...
 * @author Ryan
 */
class ST_SpriteSheet extends Tilesheet{

	public var animationStates:Map<String, ST_AnimationState>;
	public var currentState:ST_AnimationState;
	private var imageWidth:Int;
	private var imageHeight:Int;
	private var addedTiles:Int;
	
	/** No docs yet */
	public function new(_bitmapPath:String) 
	{
		super(Assets.getBitmapData(_bitmapPath));
		var bitmap:Bitmap = new Bitmap(Assets.getBitmapData(_bitmapPath));
		imageHeight = Math.round(bitmap.height);
		imageWidth = Math.round(bitmap.width);
		animationStates = new Map();
	}
	
	/** No docs yet */
	public function addAnimationState(_name:String, _frames:Array<Int>, _frameRate:Int, _frameWidth:Int, _frameHeight:Int):Void
	{
		var frameRects:Array<Rectangle> = ST_SpriteSheetHandler.getSpriteArray(imageWidth,imageHeight,_frameWidth,_frameHeight,_frames);
		
		for(i in frameRects)
		{
			addTileRect(i);
		}
		
		var tileIds:Array<Int> = new Array();
		
		for(i in addedTiles...addedTiles + _frames.length)
		{
			tileIds.push(addedTiles);
			addedTiles++;
		}
		
		animationStates.set(_name, new ST_AnimationState(tileIds, _frameRate));
	}
}