package states;

import luxe.Vector;
import luxe.Input;
import luxe.Color;
import luxe.Sprite;
import luxe.Visual;

import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

class MenuState extends luxe.States.State {

  public function new(json:Dynamic) {
    super(json);
  }

  override function onenter<T>(_:T) {

  } //onenter

  override function onmousedown( event:MouseEvent ) {

  } //onmousemove

  override function onleave<T>(_:T) {
    //Destory everything nicely,
    // fixed.destroy();
    // fixed = null;


  } //onleave

  override function update(dt:Float) {

  }

}
