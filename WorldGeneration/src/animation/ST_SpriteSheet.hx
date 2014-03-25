package animation;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import openfl.Assets;
import openfl.display.Tilesheet;
import flash.display.Bitmap;
import flash.geom.Point;

/**
 * ...
 * @author Ryan
 */
class ST_SpriteSheet extends Tilesheet{
	public var bitmapData:BitmapData;
	public var animationStates:Map<String, ST_AnimationState>;
	public var currentState:ST_AnimationState;
	private var imageWidth:Int;
	private var imageHeight:Int;
	private var addedTiles:Int;
	public var tileCorners:Array<Point>;
	
	/** No docs yet */
	public function new(_bitmapPath:String) 
	{
		bitmapData = Assets.getBitmapData(_bitmapPath);
		super(bitmapData);
		imageHeight = Math.round(bitmapData.height);
		imageWidth = Math.round(bitmapData.width);
		animationStates = new Map();
		tileCorners = new Array<Point>();
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
			tileCorners.insert(addedTiles, new Point(getTileRect(addedTiles).x, getTileRect(addedTiles).y));
			addedTiles++;
		}
		
		animationStates.set(_name, new ST_AnimationState(tileIds, _frameRate));
	}
}