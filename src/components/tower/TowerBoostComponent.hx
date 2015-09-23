package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerBoostComponent extends Component {

  public var boosting : Bool;
  public var acceleration : Vector;
  public var boost_power : Float;

  public var destination : Vector;
  public var close_enough_to_destination : Float;

  public var max_fuel : Float;
  public var fuel : Float;

  public var fuel_recharge : Float;

  private var cooldown : TowerCooldownComponent;
  private var movement : TowerMovementComponent;
  private var breaks : TowerBreakComponent;
  private var tower : Visual;

  override function init() {
    trace('init');
    boosting = false;
    acceleration = new Vector(0,0);

    tower = cast entity;
    cooldown = cast get('cooldown');
    movement = cast get('movement');
    breaks = cast get('break');
  } //init

  override function update(dt:Float) {
    if (boosting == true){
      acceleration = Vector.Subtract(destination,tower.pos).normalized.multiplyScalar(boost_power);
      movement.velocity.x += (acceleration.x * dt);
      movement.velocity.y += (acceleration.y * dt);

      if (fuel > boost_power){
        fuel -= boost_power;
      }else{
        fuel = 0;
        boostOff();
      }

      if (Vector.Subtract(destination,tower.pos).length < close_enough_to_destination){
        boostOff();
      }
    }else{
      if (fuel < max_fuel){
        fuel += fuel_recharge;
      }else{
        fuel = max_fuel;
      }
    }


  } //update

  public function setup(boostPower:Float, maxFuel: Float, fuelRecharge:Float) {
    trace('setup');
    boost_power = boostPower;
    max_fuel = maxFuel;
    fuel = max_fuel;
    fuel_recharge = fuelRecharge;
  } //init

  public function boostOn(dest:Vector, closeEnough:Float){
    if (cooldown.ready == true){
      destination = dest;
      close_enough_to_destination = closeEnough;
      breaks.breaking = false;
      boosting = true;
      cooldown.action();
    }

  }

  public function boostOff(){
    breaks.breaking = true;
    boosting = false;
  }
}
