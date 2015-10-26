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
      if ((movement.velocity.x != 0) || (movement.velocity.y != 0)){
        utility_vector.x = 0;
        utility_vector.y = 0;

        utility_vector.x = movement.velocity.x * -1;
        utility_vector.y = movement.velocity.y * -1;

        utility_vector.normalize();


        //Crappy hack
        utility_float = movement.velocity.lengthsq;
        if (Math.pow(break_friction_power,2) < utility_float){
           utility_vector.multiplyScalar(break_friction_power);
        }else{
           utility_vector.multiplyScalar(Math.sqrt(utility_float));
        }

        acceleration.acceleration.add(utility_vector);
      }
    }
  } //update

  public function setup(fric:Float) {
    breaking = true;
    break_friction_power = fric;
  } //init

}
