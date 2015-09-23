package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerBreakComponent extends Component {

  public var break_friction_power : Float;
  public var breaking : Bool;
  private var movement : TowerMovementComponent;
  private var tower : Visual;

  override function init() {
    breaking = true;
    tower = cast entity;
    movement = cast get('movement');
  } //init

  override function update(dt:Float) {
    if (breaking == true){
      if (movement.velocity.length > break_friction_power){
        movement.velocity.add(movement.velocity.inverted.normalized.multiplyScalar(break_friction_power));
      } else {
        movement.velocity.x = 0;
        movement.velocity.y = 0;
      }
    }
  } //update

  public function setup(fric:Float) {
    break_friction_power = fric;
  } //init

}
