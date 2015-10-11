package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;

class CooldownComponent extends Component {

  public var ready : Bool;
  public var max_cooldown : Float;
  public var cooldown : Float;

  private var TAG = 'CooldownComponent';
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
    cooldown_recharge = cooldownRecharge;
  } //init

  public function action() {
    ready = false;
    cooldown = 0;
  }
}
