package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class AccelerationComponent extends Component {

  public static var TAG = 'AccelerationComponent';

  private var tower : Visual;
  private var movement : MovementComponent;
  public var acceleration : Vector;

  public function new(json:Dynamic){
    super(json);
    acceleration = new Vector(0,0);
  }
  override function init() {
    tower = cast entity;
    movement = cast get(MovementComponent.TAG);

  } //init

  override function update(dt:Float) {

    movement.velocity.x += (acceleration.x * dt);
    movement.velocity.y += (acceleration.y * dt);

    acceleration.x = 0;
    acceleration.y = 0;

  } //update

  public function setup(top_s:Float) {

  } //init

}
