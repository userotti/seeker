package components.hud;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;

import components.tower.TowerBoostComponent;

class FuelStatBarComponent extends Component {

  private static var TAG = 'FuelStatBarComponent';
  private var full : Float;
  private var tower : Visual;
  private var statbar : Sprite;

  private var boost_component : TowerBoostComponent;

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

  public function setTower(entityName:String){
    boost_component = cast Luxe.scene.entities.get(entityName).get('boost');
  }
}
