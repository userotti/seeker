package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerMovementComponent extends Component {

  private var TAG = 'TowerMovementComponent';
  public var velocity : Vector;
  private var tower : Visual;

  override function init() {
    trace('init');
    velocity = new Vector(0,0);
    tower = cast entity;
  } //init

  override function update(dt:Float) {

    tower.pos.x += (velocity.x * dt);
    tower.pos.y += (velocity.y * dt);

  } //update

  public function setup(top_s:Float) {
    trace('setup');

  } //init

}
