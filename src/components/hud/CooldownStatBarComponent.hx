package components.hud;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Entity;



import components.tower.CooldownComponent;

class CooldownStatBarComponent extends Component {

  private static var TAG = 'CooldownStatBarComponent';
  private var full : Float;
  private var tower : Visual;
  private var statbar : Sprite;
  private var cooldown_component : CooldownComponent;

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

  public function setTower(_tower:Entity){
    cooldown_component =  _tower.get(CooldownComponent.TAG);
  }
}
