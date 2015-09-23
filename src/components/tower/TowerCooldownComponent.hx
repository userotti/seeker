package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;

class TowerCooldownComponent extends Component {

  public var ready : Bool;

  private var TAG = 'TowerCooldownComponent';
  private var max_cooldown : Float;
  private var cooldown : Float;
  private var cooldown_recharge : Float;
  private var tower : Visual;

  override function init() {
    trace('init');
    max_cooldown = 100;
    cooldown = 100;
    ready = true;

  } //init

  override function update(dt:Float) {
    if (cooldown < max_cooldown){
      cooldown += cooldown_recharge;
    }else{
      cooldown = max_cooldown;
      ready = true;
    }
  } //update

  public function setup(cooldownRecharge:Float) {
    trace('setup');
    cooldown_recharge = cooldownRecharge;
  } //init

  public function action() {
    ready = false;
    cooldown = 0;
  }
}
