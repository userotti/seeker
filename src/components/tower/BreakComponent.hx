package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class BreakComponent extends Component {

  public var break_friction_power : Float;
  public var breaking : Bool;
  private var acceleration : AccelerationComponent;
  private var movement : MovementComponent;
  private var tower : Visual;

  private var utility_vector : Vector;

  public function new(json:Dynamic){
    super(json);
    utility_vector = new Vector(0,0);
  }

  override function init() {
    breaking = true;
    tower = cast entity;
    acceleration = cast get('acceleration');
    movement = cast get('movement');
  } //init

  override function update(dt:Float) {
    if ((breaking == true) && (movement.velocity.x != 0) && (movement.velocity.y != 0)){
      utility_vector.x = 0;
      utility_vector.y = 0;

      utility_vector.x = movement.velocity.x * -1;
      utility_vector.y = movement.velocity.y * -1;

      utility_vector.normalize();
      utility_vector.multiplyScalar(break_friction_power);

      acceleration.acceleration.add(utility_vector);
    }
  } //update

  public function setup(fric:Float) {
    break_friction_power = fric;
  } //init

}
