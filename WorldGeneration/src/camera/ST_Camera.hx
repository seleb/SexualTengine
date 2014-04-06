package camera;
import flash.geom.Rectangle;

/**
 * ...
 * @author ryan
 */
class ST_Camera
{
	public var frame:Rectangle;
	private var deadzone:Rectangle;
	private var followSprite:ST_Sprite;

	/**
	 * A basic virtual camera which makes use of a sprites scrollRect
	 * Intended for use the main container sprite but in theory it could be used on any
	 * diplay object which has the scrollRectParameter. The scrollRect of the parent display
	 * object must be set each frame. This rectangle can be obtained by calling getFrame()
	 * 
	 * @param	_x The x position of the camera frame
	 * @param	_y The y position of the camera frame
	 * @param	_width The width of the camera frame
	 * @param	_height The height of the camera frame
	 * @param	_deadzoneWidth The width of the cameras deadzone
	 * @param	_deadzoneHeight The height of the cameras deadzone
	 */
	public function new(_x:Float , _y:Float, _width:Float, _height:Float, _deadzoneWidth:Float, _deadzoneHeight:Float) {
		frame = new Rectangle(_x, _y, _width, _height);
		deadzone = new Rectangle(_x + (_width - _deadzoneWidth) / 2, _y +(_height / _deadzoneHeight) / 2, _deadzoneWidth, _deadzoneHeight);
		var dummySprite:ST_Sprite = new ST_Sprite();
		dummySprite.x = frame.width / 2;
		dummySprite.y = frame.height / 2;
		dummySprite.width = 0;
		dummySprite.height = 0;
		followSprite = dummySprite;
	}
	
	/**
	 * Sets a sprite target for the camera. The camera will not
	 * move until the sprite is at the edge of the deadzone;
	 * 
	 * @param	_followSprite
	 */
	public function follow(_followSprite:ST_Sprite) {
		followSprite = _followSprite; 
	}
	
	/**
	 * Used to set the width and height of the camera's deadzone
	 * The deadzone will alaways be centered in the camera
	 * 
	 * @param	_width
	 * @param	_height
	 */
	public function setDeadzone(_width:Float, _height:Float) {
		deadzone = new Rectangle((frame.width - _width) / 2, (frame.height - _height) / 2 , _width, _height);
	}
	
	/**
	 * Calculates and returns the current position for the
	 * camera's frame based on the follow sprite's position within
	 * the deadzone
	 * 
	 * @return A rectangle representing the cameras current frame state
	 */
	public function getFrame():Rectangle {
		
		if (followSprite.x <= deadzone.x){
			deadzone.x = followSprite.x;
		}
		if (followSprite.x + followSprite.width >= deadzone.x + deadzone.width) {
			deadzone.x = followSprite.x + followSprite.width - deadzone.width;
		}
		if(followSprite.y <= deadzone.y){
			deadzone.y = followSprite.y;
		}
		if (followSprite.y + followSprite.height >= deadzone.y + deadzone.height) {
			deadzone.y = followSprite.y + followSprite.height - deadzone.height;
		}
		frame.x = deadzone.x - (frame.width - deadzone.width) / 2;
		frame.y = deadzone.y - (frame.height - deadzone.height) / 2;
		return frame;
	}
}
