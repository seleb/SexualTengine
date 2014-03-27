package physics;
import flash.geom.Point;

/**
 * ...
 * @author Ryan
 */
class ST_Physics
{
	public var mass:Float;
	public var velocity:Point;
	public var acceleration:Point;
	public var force:Float;
	public var appliedForces:Array<Point> ;
	public var friction:Float;
	public var maxVelocity:Point;
	
	
	public function new(?_mass:Float = 1) {
		velocity = new Point(0,0);
		acceleration = new Point(0, 0);
		maxVelocity = new Point(0, 0);
		friction = 0;
		mass = _mass;
	}
	
	public function calculatePosition():Point{
		
		var reutrnPoint;
		
		if (acceleration.x != 0) {
			velocity.x += acceleration.x;
		}
		if (acceleration.y != 0) {
			velocity.y += acceleration.y;
		}
		
		reutrnPoint = new Point(velocity.x, velocity.y);
		
		//Apply the friction after the movement has occured
		velocity.x *= friction;
		velocity.y *= friction;
		
		return reutrnPoint;
	}
	
	public function resetAcceleration() {
		acceleration = new Point(0, 0);
	}
	
	public function applyForce(_trajectory:Point, _magnitude:Float) {
		appliedForces.push(_trajectory);
	}
	
}