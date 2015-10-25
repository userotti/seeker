package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class BoostComponent extends Component {

  public static var TAG = 'BoostComponent';

  public var boosting : Bool;
  public var boost_vector : Vector;
  public var boost_power : Float;
  public var destination : Vector;
  public var close_enough_to_destination : Float;
  public var max_fuel : Float;
  public var fuel : Float;
  public var fuel_recharge : Float;

  private var cooldown : CooldownComponent;
  private var acceleration_comp : AccelerationComponent;
  private var breaks : BreakComponent;
  private var tower : Visual;
  private var boost_smoke_counter : Float;




  public function new(json:Dynamic){
    super(json);
    boost_vector = new Vector(0,0);
  }

  override function init() {
    boosting = false;

    boost_vector.x = 0;
    boost_vector.y = 0;

    boost_smoke_counter = 0;

    tower = cast entity;
    cooldown = cast get(CooldownComponent.TAG);
    acceleration_comp = cast get(AccelerationComponent.TAG);
    breaks = cast get(BreakComponent.TAG);
  } //init

  override function update(dt:Float) {
    if (boosting == true){
      boost_vector.x = 0;
      boost_vector.y = 0;

      boost_vector.x = destination.x - tower.pos.x;
      boost_vector.y = destination.y - tower.pos.y;
      boost_vector.normalize();
      boost_vector.multiplyScalar(boost_power);
      acceleration_comp.acceleration.add(boost_vector);

      boost_smoke_counter++;


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
