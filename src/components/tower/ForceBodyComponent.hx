package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Color;
import luxe.collision.shapes.*;
import com.elnabo.quadtree.*;

class ForceBodyComponent extends Component implements QuadtreeElement {

  public static var TAG = 'ForceBodyComponent';

  public var tower : Visual;
  public var radius : Float;
  public var total_force : Vector;
  public var total_force_record : Vector;
  public var being_forced : Bool;

  private var bounding_box : Box;

  public function new(json:Dynamic){
    super(json);
    total_force = new Vector(0,0);
    total_force_record = new Vector(0,0);
    bounding_box = new Box(0,0,0,0);
  }

  override function init() {
    tower = cast entity;
    radius = 1;
    bounding_box.width = 2;
    bounding_box.height = 2;


    //trace('childeren '+tower.get_any('forceindicator', true, true).length);
  } //init

  override function update(dt:Float) {

    bounding_box.x = Std.int(tower.pos.x-(bounding_box.width/2));
    bounding_box.y = Std.int(tower.pos.y-(bounding_box.height/2));

    if (being_forced == true){
      total_force_record.x = total_force.x;
      total_force_record.y = total_force.y;
      tower.get(AccelerationComponent.TAG).acceleration.add(total_force);
      total_force.x = 0;
      total_force.y = 0;
      being_forced = false;
    }else{
      total_force_record.x = 0;
      total_force_record.y = 0;
    }




  } //update

  public function setRadius(_r:Float){
    radius = _r;
  }

  public function box(){
    return bounding_box;
  }


}
