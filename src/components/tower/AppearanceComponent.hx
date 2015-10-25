package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class AppearanceComponent extends Component {

  public static var TAG = 'AppearanceComponent';

  private var booster : BoostComponent;
  private var tower : Visual;

  override function init() {
    tower = cast entity;
    booster = cast get(BoostComponent.TAG);
  } //init

  override function update(dt:Float) {
    tower.rotation_z = (Math.atan2(booster.boost_vector.y, booster.boost_vector.x) / Math.PI) * 180 + 90;
  } //update

  public function setup() {

  } //init

}
