package components.utility;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Color;
import luxe.collision.shapes.*;
import components.tower.ForceManagerComponent;

class ForceIndicatorManager extends Component {

  public var indicator : Sprite;
  public var parent : Sprite;
  public var force : Vector;

  public function new(json:Dynamic){
    super(json);
    force = new Vector(0,0);
  }

  override function init() {
    indicator = cast entity;
    parent = cast (indicator.parent, Sprite);
    trace('hom: ' + parent.rotation_z);

  } //init

  override function update(dt:Float) {



    if((Math.abs(force.x) > 0) || (Math.abs(force.y) > 0)) {
      indicator.visible = true;
      indicator.rotation_z = (Math.atan2(force.x, force.y) / Math.PI  * 180) - parent.rotation_z;
    }else{
      indicator.visible = false;
    }
  } //update

  public function setForce(x:Float, y:Float){
    force.x = x;
    force.y = y;

  }

}
