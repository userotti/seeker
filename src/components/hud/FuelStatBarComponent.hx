package components.hud;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Entity;

import components.tower.BoostComponent;

class FuelStatBarComponent extends Component {

  private static var TAG = 'FuelStatBarComponent';
  private var full : Float;
  private var tower : Visual;
  private var statbar : Sprite;

  private var boost_component : BoostComponent;

  public function new(json:Dynamic) {
    super(json);
    full = -100;
  }

  override function init() {
    statbar = cast entity;
    statbar.size.x = 10;
    statbar.size.y = full;
  } //init

  override function update(dt:Float) {
    statbar.size.y = (boost_component.fuel / boost_component.max_fuel) * full;
  } //update

  public function setTower(_tower:Entity){
    boost_component = _tower.get('boost');
  }
}
