package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Color;
import luxe.collision.shapes.*;
import components.tower.ForceBodyComponent;

class TimedKillComponent extends Component {

  public static var TAG = 'TimedKillComponent';

  public var sprite : Sprite;
  public var lifetime : Float;
  public var age : Float;

  public function new(json:Dynamic){
    super(json);
    lifetime = 0;
    age = 0;
  }

  override function init() {
    sprite = cast entity;
  } //init

  override function update(dt:Float) {
    age += dt;
    if (age > lifetime){
      sprite.visible = false;
      sprite.active = false;
    }
  } //update

  public function setup(_lifetime: Float, _age: Float){
    lifetime = _lifetime;
    age = _age;


  }
}
