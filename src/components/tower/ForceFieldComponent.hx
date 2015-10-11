package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Entity;

import components.tower.ForceBodyComponent;

import luxe.Color;
import luxe.collision.shapes.*;

class ForceFieldComponent extends Component {

  private var shape : Circle;
  public var radius : Float;
  private var tower : Visual;
  public var constant_force : Float;

  private var utility_vector : Vector;
  public function new(json:Dynamic){
    super(json);
    utility_vector = new Vector(0,0);
    radius = 0;
    constant_force = 0;
  }

  override function init() {
    tower = cast entity;

  } //init

  override function update(dt:Float) {

  } //update

  public function force(body:ForceBodyComponent) {
    utility_vector.x = body.pos.x - pos.x;
    utility_vector.y = body.pos.y - pos.y;

    utility_vector.normalize();
    utility_vector.multiplyScalar(constant_force);
    body.tower.get('acceleration').acceleration.add(utility_vector);
  } //update

  public function setup (_r:Float, _f:Float){
    setRadius(_r);
    setForce(_f);
  }
  public function setRadius(_r:Float){
    radius = _r;
  }

  public function setForce(_f:Float){
    constant_force = _f;
  }


}
