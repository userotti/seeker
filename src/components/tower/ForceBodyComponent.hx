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

  public function new(json:Dynamic){
    super(json);

  }

  override function init() {
    tower = cast entity;
    force_manager = cast get('force_manager');
    radius = 1;

  } //init


  override function update(dt:Float) {
    force_manager.force(this);
  } //update

  public function setRadius(_r:Float){
    radius = _r;
  }


}
