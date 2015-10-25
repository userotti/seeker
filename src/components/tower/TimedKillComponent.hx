package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Color;
import luxe.collision.shapes.*;
import components.tower.ForceBodyComponent;

class TimedKillComponent extends Component {

  public var sprite : Sprite;
  public var lifetime : Float;
  public var age : Float;




  public function new(json:Dynamic){
    super(json);
  }

  override function init() {
    sprite = cast entity;
    lifetime = 0;
    age = 0;



  } //init

  override function update(dt:Float) {
    age += dt;
    if (age > lifetime){
      sprite.visible = false;
      sprite.active = false;
    }
  } //update

  public function setup(_lifetime: Float){
    lifetime = _lifetime;
  }
}
