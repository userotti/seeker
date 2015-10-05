package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerFrictionComponent extends Component {

  public var friction : Vector;
  public var friction_power : Float;
  private var acceleration : TowerAccelerationComponent;
  private var movement : TowerMovementComponent;
  private var tower : Visual;

  override function init() {
    tower = cast entity;

    acceleration = cast get('acceleration');
    movement = cast get('movement');
  } //init

  override function update(dt:Float) {
    if (movement.velocity.lengthsq > 0){
      acceleration.acceleration.add(movement.velocity.inverted.normalized.multiplyScalar(friction_power));
    }
  } //update

  public function setup(fric:Float) {
    friction_power = fric;
  } //init

}
