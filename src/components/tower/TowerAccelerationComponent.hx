package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerAccelerationComponent extends Component {

  private var TAG = 'TowerAccelerationComponent';
  private var tower : Visual;
  private var movement : TowerMovementComponent;
  public var acceleration : Vector;

  public function new(json:Dynamic){
    trace('new');
    super(json);
    acceleration = new Vector(0,0);
  }
  override function init() {
    trace('init');
    tower = cast entity;
    movement = cast get('movement');

  } //init

  override function update(dt:Float) {

    movement.velocity.x += (acceleration.x * dt);
    movement.velocity.y += (acceleration.y * dt);

    acceleration.x = 0;
    acceleration.y = 0;

  } //update

  public function setup(top_s:Float) {
    trace('setup');

  } //init

}
