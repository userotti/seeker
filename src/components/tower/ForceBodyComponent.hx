package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Color;
import luxe.collision.shapes.*;
import com.elnabo.quadtree.*;

import components.effects.*;

class ForceBodyComponent extends Component implements QuadtreeElement {

  public static var TAG = 'ForceBodyComponent';

  public var owner : Sprite;
  public var hit_radius : Float;
  public var total_force : Vector;
  public var total_force_record : Vector;
  public var being_forced : Bool;
  public var has_indicator : Bool;
  public var indicator : DirectionIndicatorComponent;

  private var bounding_box : Box;

  public function new(json:Dynamic){
    super(json);
    total_force = new Vector(0,0);
    total_force_record = new Vector(0,0);
    bounding_box = new Box(0,0,0,0);
    hit_radius = 0;

  }

  override function init() {
    owner = cast(this.entity, Sprite);
    bounding_box.x = Std.int(owner.pos.x-(hit_radius));
    bounding_box.y = Std.int(owner.pos.y-(hit_radius));
  } //init

  override function update(dt:Float) {

    bounding_box.x = Std.int(owner.pos.x-(hit_radius));
    bounding_box.y = Std.int(owner.pos.y-(hit_radius));

    if (being_forced == true){

      //manage my own indicator
      if (has_indicator == false){

        Luxe.events.fire('attach_force_indicator', {force_body: this});
        has_indicator = true;
      }

      if (indicator != null){
        indicator.direction_vector.x = total_force.x;
        indicator.direction_vector.y = total_force.y;
      }



      total_force_record.x = total_force.x;
      total_force_record.y = total_force.y;
      owner.get(AccelerationComponent.TAG).acceleration.add(total_force);
      total_force.x = 0;
      total_force.y = 0;
      being_forced = false;

    }else{

      //manage my own indicator

      if (has_indicator == true){
        Luxe.events.fire('kill_effect', {effect: this.indicator.indicator});
        this.indicator = null;
        has_indicator = false;
      }


      total_force_record.x = 0;
      total_force_record.y = 0;
    }

  } //update

  public function setup(_hit_radius:Float){

    has_indicator = false;
    bounding_box.width = Std.int(hit_radius*2);
    bounding_box.height = Std.int(hit_radius*2);

  }

  public function box(){
    return bounding_box;
  }


}
