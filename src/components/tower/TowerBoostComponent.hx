package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class TowerBoostComponent extends Component {

  public var boosting : Bool;
  public var boost_vector : Vector;
  public var boost_power : Float;
  public var destination : Vector;
  public var close_enough_to_destination : Float;
  public var max_fuel : Float;
  public var fuel : Float;
  public var top_speed: Float;
  public var fuel_recharge : Float;
  private var cooldown : TowerCooldownComponent;
  private var acceleration_comp : TowerAccelerationComponent;
  private var breaks : TowerBreakComponent;
  private var tower : Visual;

  public function new(json:Dynamic){
    super(json);
    boost_vector = new Vector(0,0);
  }

  override function init() {
    trace('init');
    boosting = false;

    boost_vector.x = 0;
    boost_vector.y = 0;

    tower = cast entity;
    cooldown = cast get('cooldown');
    acceleration_comp = cast get('acceleration');
    breaks = cast get('break');
  } //init

  override function update(dt:Float) {
    if (boosting == true){
      boost_vector = Vector.Subtract(destination,tower.pos).normalized.multiplyScalar(boost_power);
      acceleration_comp.acceleration.add(boost_vector);

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

  public function setup(boostPower:Float, topSpeed: Float, maxFuel: Float, fuelRecharge:Float) {
    trace('setup');
    boost_power = boostPower;
    max_fuel = maxFuel;
    fuel = max_fuel;
    fuel_recharge = fuelRecharge;
    top_speed = topSpeed;
  } //init

  public function boostOn(dest:Vector, closeEnough:Float){
    trace('boostOn');
    if (cooldown.ready == true){
      destination = dest;
      close_enough_to_destination = closeEnough;
      breaks.breaking = false;
      boosting = true;
      cooldown.action();
    }

  }

  public function boostOff(){
    trace('boostOff');
    breaks.breaking = true;
    boosting = false;
  }
}
