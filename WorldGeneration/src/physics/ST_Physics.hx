package physics;
import flash.geom.Point;

/**
 * ...
 * @author Ryan
 */
class ST_Physics
{
	public var velocity:Point;
	public var acceleration:Point;
	private var appliedForces:Array<Point> ;
	public var friction:Float;
	
	public function new() {
		velocity = new Point(0,0);
		acceleration = new Point(0, 0);
		friction = 0;
		appliedForces = new Array();
	}
	
	/*
	 * Used to calculate the values for x and y that the object should be moved
	 * Applies any forces in the appliedForces array and applies friction 
	 * to the current velocity of the object <strong> Friction is inverted meaning
	 * 0 is equal to 100% friction and 1 is eaual to 0% Friction</strong>
	 * 
	 * @return A point containing the x and y offset for the object 
	 */
	public function calculatePosition():Point{
		
		var reutrnPoint;
		
		//Adjust the accleration by applying forces for the frame
		
		for (p in appliedForces) {
			acceleration.x += p.x;
			acceleration.y += p.y;
		}
		
		appliedForces = new Array();
		
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
	
	/*
	 * Resets the acceleration to a new Point of 0,0 
	 */
	public function resetAcceleration() {
		acceleration = new Point(0, 0);
	}
	
	/*
	 * Applies a force to the object which is applied in the 
	 * @see calculatePosition method. For example a trajectory of (2,0)
	 * would cause the object to move right with a magnitude of 2
	 * 
	 * @param _trajectory The x and y trajectory values to be applied to the object
	 */
	public function applyForce(_trajectory:Point) {
		appliedForces.push(_trajectory);
	}
	
}