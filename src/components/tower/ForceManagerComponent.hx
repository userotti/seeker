package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Scene;
import luxe.Entity;
import components.tower.ForceBodyComponent;
import components.tower.ForceFieldComponent;

class ForceManagerComponent extends Component {

  public var entities : Array<Entity>;
  public var entities_iterator : Iterator<Entity>;
  public var collision_scene : Scene;

  //utility
  public var utility_force_field : ForceFieldComponent;

  public function new(json:Dynamic, _collision_scene:Scene){
    super(json);
    collision_scene = _collision_scene;
  }
  override function init() {
    entities_iterator = collision_scene.entities.iterator();

  } //init

  public function force(body: ForceBodyComponent){

    for(tower in collision_scene.entities){
      if (body.tower.name != tower.name){
        utility_force_field = tower.get('forcefield');
        if (utility_force_field != null){
          if(simpleCollision(body, utility_force_field)){
            body.being_forced = true;
            utility_force_field.force(body);
          }
        }
      }
    }
  }

  public function simpleCollision(_body:ForceBodyComponent, _field: ForceFieldComponent){

    if (Math.abs(_body.pos.x - _field.pos.x) < _field.radius){
      if (Math.abs(_body.pos.y - _field.pos.y) < _field.radius){
        if ((Math.pow(_body.pos.x - _field.pos.x, 2) + Math.pow(_body.pos.y - _field.pos.y, 2)) < Math.pow(_body.radius - _field.radius, 2)){
          return true;
        }
      }
    }

    return false;

  }
  override function update(dt:Float) {
    //organize the quadtree

  } //update


}
