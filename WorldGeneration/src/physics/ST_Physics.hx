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
	private var appliedForces:Array<Point> ;
	public var friction:Float;
	public var maxVelocity:Point;
	
	
	public function new(?_mass:Float = 1) {
		velocity = new Point(0,0);
		acceleration = new Point(0, 0);
		maxVelocity = new Point(0, 0);
		friction = 0.7;
		appliedForces = new Array();
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
		acceleration.x *= friction;
		acceleration.y *= friction;
		
		for (p in appliedForces) {
			acceleration.x += p.x;
			acceleration.y += p.y;
		}
		
		appliedForces = new Array();
		
		return reutrnPoint;
	}
	
	public function applyForce(_trajectory:Point) {
		appliedForces.push(_trajectory);
	}
	
}