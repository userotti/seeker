package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerMovementComponent extends Component {

  private var TAG = 'TowerMovementComponent';
  public var top_speed : Float;
  public var velocity : Vector;
  private var tower : Visual;

  override function init() {
    trace('init');
    velocity = new Vector(0,0);
    tower = cast entity;
  } //init

  override function update(dt:Float) {

    if (velocity.length > top_speed){
      velocity = velocity.normalized.multiplyScalar(top_speed);
    }

    tower.pos.x += (velocity.x * dt);
    tower.pos.y += (velocity.y * dt);
  } //update

  public function setup(top_s:Float) {
    trace('setup');
    top_speed = top_s;
  } //init

}
