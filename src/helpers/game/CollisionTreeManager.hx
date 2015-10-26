package helpers.game;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Scene;
import luxe.Entity;

import components.tower.*;
import com.elnabo.quadtree.*;

class CollisionTreeManager {

  public var entities : Array<Entity>;
  public var entities_iterator : Iterator<Entity>;
  public var collision_tree : Quadtree<QuadtreeElement>;

  //utility
  private var entity_components : Array<Component>;

  public function new(){
    collision_tree = new Quadtree<QuadtreeElement>(new Box(-1000,-1000, 2000, 2000), 5, 3);
  }

  public function rebuild(_entities : Array<Entity>){

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

      entity_components = entity.get_any(DefenceComponent.TAG, true);
      for(component in entity_components){
        collision_tree.remove(cast(component, QuadtreeElement));
        collision_tree.add(cast(component, QuadtreeElement));
      }

      entity_components = entity.get_any(OffenceComponent.TAG, true);
      for(component in entity_components){
        collision_tree.remove(cast(component, QuadtreeElement));
        collision_tree.add(cast(component, QuadtreeElement));
      }
    }
  }

  public function removeEntity(_entity:Entity){
    entity_components = _entity.get_any(ForceBodyComponent.TAG, true);
    for(component in entity_components){
      collision_tree.remove(cast(component, QuadtreeElement));
    }

    entity_components = _entity.get_any(ForceFieldComponent.TAG, true);
    for(component in entity_components){
      collision_tree.remove(cast(component, QuadtreeElement));
    }

    entity_components = _entity.get_any(DefenceComponent.TAG, true);
    for(component in entity_components){
      collision_tree.remove(cast(component, QuadtreeElement));
    }

    entity_components = _entity.get_any(OffenceComponent.TAG, true);
    for(component in entity_components){
      collision_tree.remove(cast(component, QuadtreeElement));
    }

  }

}
