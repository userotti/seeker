package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Color;
import luxe.collision.shapes.*;
import components.tower.ForceManagerComponent;

class ForceBodyComponent extends Component {

  public var tower : Visual;
  public var radius : Float;
  private var force_manager : ForceManagerComponent;
  public var total_force : Vector;
  public var total_force_record : Vector;
    public var being_forced : Bool;

  public function new(json:Dynamic){
    super(json);
    total_force = new Vector(0,0);
    total_force_record = new Vector(0,0);
  }

  override function init() {
    tower = cast entity;
    force_manager = cast get('force_manager');
    radius = 1;

    //trace('childeren '+tower.get_any('forceindicator', true, true).length);
  } //init

  override function update(dt:Float) {
    force_manager.force(this);

    if (being_forced == true){
      total_force_record.x = total_force.x;
      total_force_record.y = total_force.y;
      tower.get('acceleration').acceleration.add(total_force);
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


}
