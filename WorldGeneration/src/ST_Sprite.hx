package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import openfl.Assets;
import animation.ST_AnimationManager;

/**
 * ...
 * @author Sean
 */
class ST_Sprite extends Sprite{
	private var bitmap:Bitmap;
	public var animation:ST_AnimationManager;
	
	public function new(?_bitmap:String){
		super();
		if(_bitmap != null){
			bitmap = new Bitmap(Assets.getBitmapData(_bitmap));
			addChild(bitmap);
		}else {
			bitmap = new Bitmap();
		}
		animation = new ST_AnimationManager(this.graphics);
	}
	
	
	public function setBitmap(_bitmap:String) {
		bitmap = new Bitmap(Assets.getBitmapData(_bitmap));
		addChild(bitmap);
	}
	public function getBitmap():Bitmap {
		return bitmap;
	}
}