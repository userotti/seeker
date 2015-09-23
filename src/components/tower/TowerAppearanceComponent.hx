package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerAppearanceComponent extends Component {

  private var booster : TowerBoostComponent;
  private var tower : Visual;

  override function init() {
    tower = cast entity;
    booster = cast get('boost');
  } //init

  override function update(dt:Float) {
    tower.rotation_z = (Math.atan2(booster.acceleration.y, booster.acceleration.x) / Math.PI) * 180;
  } //update

  public function setup() {

  } //init

}
