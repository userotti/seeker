package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class MovementComponent extends Component {

  private var TAG = 'AccelerationComponent';
  public var velocity : Vector;
  private var tower : Visual;


  public function new(json:Dynamic){
    super(json);
    velocity = new Vector(0,0);
  }
  override function init() {
    tower = cast entity;
    velocity.x = 0;
    velocity.y = 0;

  } //init

  override function update(dt:Float) {

    tower.pos.x += (velocity.x * dt);
    tower.pos.y += (velocity.y * dt);

  } //update

  public function setup(top_s:Float) {
    trace('setup');

  } //init

}
