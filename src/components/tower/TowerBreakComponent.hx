package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerBreakComponent extends Component {

  public var break_friction_power : Float;
  public var breaking : Bool;
  private var acceleration : TowerAccelerationComponent;
  private var movement : TowerMovementComponent;
  private var tower : Visual;

  override function init() {
    breaking = true;
    tower = cast entity;

    acceleration = cast get('acceleration');
    movement = cast get('movement');
  } //init

  override function update(dt:Float) {
    if ((breaking == true) && (movement.velocity.lengthsq > 0)){
      acceleration.acceleration.add(movement.velocity.inverted.normalized.multiplyScalar(break_friction_power));
    }
  } //update

  public function setup(fric:Float) {
    break_friction_power = fric;
  } //init

}
