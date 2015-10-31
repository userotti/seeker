package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class FrictionComponent extends Component {

  public static var TAG = 'FrictionComponent';

  public var friction : Vector;
  public var friction_power : Float;
  private var acceleration : AccelerationComponent;
  private var movement : MovementComponent;
  private var tower : Visual;

  private var utility_float: Float;
  private var utility_vector : Vector;

  private var movement_velocity_angle : Float;
  private var final_fric : Float;

  public function new(json:Dynamic){
    super(json);
    utility_vector = new Vector(0,0);
  }
  override function init() {
    tower = cast entity;
    acceleration = cast get(AccelerationComponent.TAG);
    movement = cast get(MovementComponent.TAG);
  } //init

  override function update(dt:Float) {

    utility_float = movement.velocity.length;
    //performance check
    if (utility_float > 0.001){
      final_fric = friction_power - (friction_power + 0.05*utility_float)/(1 + 0.05*utility_float);
      utility_vector.x = movement.velocity.x * -1;
      utility_vector.y = movement.velocity.y * -1;
      utility_vector.normalize();

      utility_vector.multiplyScalar(final_fric);
      acceleration.acceleration.add(utility_vector);
    };
  } //update

  public function setup(fric:Float) {
    friction_power = fric;
  } //init

}
