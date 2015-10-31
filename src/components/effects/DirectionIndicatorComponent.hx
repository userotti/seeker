package components.effects;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;

class DirectionIndicatorComponent extends Component {

  public static var TAG = 'DirectionIndicatorComponent';

  public var indicator : Sprite;
  public var parent : Sprite;
  public var direction_vector : Vector;
  public var alive : Bool;


  public function new(json:Dynamic){
    super(json);
    direction_vector = new Vector(0,0);
  }

  override function init() {

    indicator = cast entity;

  } //init

  override function update(dt:Float) {
    indicator.rotation_z = (Math.atan2(direction_vector.y, direction_vector.x) / Math.PI) * 180;

  } //update


}
