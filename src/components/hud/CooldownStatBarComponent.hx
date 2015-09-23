package components.hud;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;

import components.tower.TowerCooldownComponent;

class CooldownStatBarComponent extends Component {

  private static var TAG = 'CooldownStatBarComponent';
  private var full : Float;
  private var tower : Visual;
  private var statbar : Sprite;

  private var cooldown_component : TowerCooldownComponent;

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
    statbar.size.y = (cooldown_component.cooldown / cooldown_component.max_cooldown) * full;
  } //update

  public function setTower(entityName:String){
    cooldown_component = cast Luxe.scene.entities.get(entityName).get('cooldown');
  }
}
