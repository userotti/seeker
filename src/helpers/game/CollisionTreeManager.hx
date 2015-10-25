package helpers.game;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Scene;
import luxe.Entity;
import components.tower.ForceBodyComponent;
import components.tower.ForceFieldComponent;
import com.elnabo.quadtree.*;

class CollisionTreeManager {

  public var entities : Array<Entity>;
  public var entities_iterator : Iterator<Entity>;
  public var collision_tree : Quadtree<QuadtreeElement>;

  //utility

  public function new(){
    collision_tree = new Quadtree<QuadtreeElement>(new Box(-1000,-1000, 2000, 2000), 5, 3);
  }

  public function rebuild(_entities : Array<Entity>){
    var entity_components : Array<Component>;
    for (entity in _entities){

      entity_components = entity.get_any(ForceBodyComponent.TAG, true);
      for(component in entity_components){
        collision_tree.remove(cast(component, QuadtreeElement));
        collision_tree.add(cast(component, QuadtreeElement));
      }

      entity_components = entity.get_any(ForceFieldComponent.TAG, true);
      for(component in entity_components){
        collision_tree.remove(cast(component, QuadtreeElement));
        collision_tree.add(cast(component, QuadtreeElement));
      }
    }
  }

  public function addComponents(_entity:Sprite) : Sprite{

    trace(collision_tree);
    return _entity;

  }


}
