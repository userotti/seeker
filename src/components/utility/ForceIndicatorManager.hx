package components.utility;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Color;
import luxe.collision.shapes.*;
import components.tower.ForceManagerComponent;
import components.tower.ForceBodyComponent;

class ForceIndicatorManager extends Component {

  public var indicator : Sprite;
  public var parent : Sprite;
  public var force_body : ForceBodyComponent;


  public function new(json:Dynamic){
    super(json);
  }

  override function init() {
    indicator = cast entity;
    parent = cast (indicator.parent, Sprite);
    force_body = parent.get('forcebody');

  } //init

  override function update(dt:Float) {
    if ((force_body.total_force_record.x != 0) || (force_body.total_force_record.y != 0)){
      indicator.visible = true;
      indicator.rotation_z = (Math.atan2(force_body.total_force_record.y, force_body.total_force_record.x) / Math.PI  * 180) - parent.rotation_z;
    }else{
      indicator.visible = false;
    }
  } //update


}
