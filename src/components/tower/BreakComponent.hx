package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class BreakComponent extends Component {

  public static var TAG = 'BreakComponent';

  public var break_friction_power : Float;
  public var breaking : Bool;
  private var acceleration : AccelerationComponent;
  private var movement : MovementComponent;
  private var tower : Visual;
  private var final_break : Float;

  private var utility_float : Float;
  private var utility_vector : Vector;

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
    if (breaking == true){
      utility_float = movement.velocity.length;
      //performance check
      if (utility_float > 0.001){
        final_break = break_friction_power - (break_friction_power + 0.05*utility_float)/(1 + 0.05*utility_float);
        utility_vector.x = movement.velocity.x * -1;
        utility_vector.y = movement.velocity.y * -1;
        utility_vector.normalize();

        utility_vector.multiplyScalar(final_break);
        acceleration.acceleration.add(utility_vector);
      };
    }
  } //update

  public function setup(fric:Float) {
    breaking = true;
    break_friction_power = fric;
  } //init

}
