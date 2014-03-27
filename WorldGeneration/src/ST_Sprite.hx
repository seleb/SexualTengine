package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import openfl.Assets;
import animation.ST_AnimationManager;
import physics.ST_Physics;

/**
 * ...
 * @author Sean
 */
class ST_Sprite extends Sprite{
	
	private var bitmap:Bitmap;
	public var animation:ST_AnimationManager;
	public var movement:ST_Physics;
	
	public function new(?_bitmap:String){
		super();
		if(_bitmap != null){
			bitmap = new Bitmap(Assets.getBitmapData(_bitmap));
			addChild(bitmap);
		}else {
			bitmap = new Bitmap();
		}
		animation = new ST_AnimationManager(this.graphics);
		movement = new ST_Physics(60);
	}
	
	public function update() {
	
		var movementVector:Point = movement.calculatePosition();
		x += movementVector.x;
		y += movementVector.y;
		trace(movement.velocity.x);
	}
	
	public function setBitmap(_bitmap:String) {
		bitmap = new Bitmap(Assets.getBitmapData(_bitmap));
		addChild(bitmap);
	}
	public function getBitmap():Bitmap {
		return bitmap;
	}
}