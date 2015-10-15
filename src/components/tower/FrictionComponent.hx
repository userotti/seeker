package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class FrictionComponent extends Component {

  public var friction : Vector;
  public var friction_power : Float;
  private var acceleration : AccelerationComponent;
  private var movement : MovementComponent;
  private var tower : Visual;

  private var utility_vector : Vector;

  public function new(json:Dynamic){
    super(json);
    utility_vector = new Vector(0,0);
  }
  override function init() {
    tower = cast entity;

    acceleration = cast get('acceleration');
    movement = cast get('movement');
  } //init

  override function update(dt:Float) {
    if ((movement.velocity.x != 0) && (movement.velocity.y != 0)){
      utility_vector.x = 0;
      utility_vector.y = 0;

      utility_vector.x = movement.velocity.x * -1;
      utility_vector.y = movement.velocity.y * -1;

      utility_vector.normalize();
      utility_vector.multiplyScalar(friction_power);

      acceleration.acceleration.add(utility_vector);
    }
  } //update

  public function setup(fric:Float) {
    friction_power = fric;
  } //init

}