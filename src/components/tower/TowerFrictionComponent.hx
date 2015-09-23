package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerFrictionComponent extends Component {

  public var friction : Vector;
  public var friction_power : Float;
  private var movement : TowerMovementComponent;
  private var tower : Visual;

  override function init() {
    tower = cast entity;
    movement = cast get('movement');
  } //init

  override function update(dt:Float) {
    if (movement.velocity.length > friction_power){
      movement.velocity.add(movement.velocity.inverted.normalized.multiplyScalar(friction_power));
    } else {
      movement.velocity.x = 0;
      movement.velocity.y = 0;
    }
  } //update

  public function setup(fric:Float) {
    friction_power = fric;
  } //init

}
