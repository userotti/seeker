package helpers.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Entity;
import luxe.Sprite;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import components.tower.*;

import components.utility.*;
import luxe.structural.Pool;

import helpers.game.LevelBuilder;
import helpers.game.CollisionTreeManager;
import helpers.game.EffectsSceneManager;

import sprites.game.*;
import pools.*;

class CollisionSceneManager extends Scene {

  public var collision_tree_manager : CollisionTreeManager;
  public var effects_scene_manager : EffectsSceneManager;
  public var static_tower_pool : StaticTowerPool;
  public var tower_pool : TowerPool;
  public var pushable_pool : PushablePool;
  public var active_entities : Array<Entity>;

  public function new() {
    super('collision_scene');
    collision_tree_manager = new CollisionTreeManager();
    active_entities = new Array<Entity>();
  };

  //Recycling Objects ===================================================
  public function getStaticTower(){
    var st = static_tower_pool.get();
    st.collision_tree = this.collision_tree_manager;
    st.active = true;
    st.visible = true;
    return st;
  };

  public function getTower(){
    var t = tower_pool.get();
    t.collision_tree = this.collision_tree_manager;
    t.active = true;
    t.visible = true;
    return t;
  };

  public function getPushable(){
    var p = pushable_pool.get();
    p.collision_tree = this.collision_tree_manager;
    p.active = true;
    p.visible = true;
    return p;
  };

  public function kill(_entity:CollidableSprite){
    _entity.active = false;
    _entity.visible = false;
    collision_tree_manager.removeEntity(_entity);

    if(_entity.collision_tree != null){
      _entity.collision_tree = null;
    }

    for (child in _entity.children){
      kill(cast(child, CollidableSprite));
    }
  }

  //SETUP POOLS ===================================================
  public function setupStaticTowerPool(_static_tower_pool_size: Int){
    static_tower_pool = new StaticTowerPool(_static_tower_pool_size, this);
  };

  public function setupTowerPool(_tower_pool_size: Int){
    tower_pool = new TowerPool(_tower_pool_size, this);
  };

  public function setupPushablePool(_pushable_pool_size: Int){
    pushable_pool = new PushablePool(_pushable_pool_size, this);
  };

  //Clean up scene =================================================
  public function destroyContents(){
    //collision_tree_manager.removeAll(entities);
    for(entity in entities){
      kill(cast(entity, CollidableSprite));
    }
    this.empty();
    static_tower_pool = null;
    tower_pool = null;
    pushable_pool = null;

  }

  //Update collision_tree  =========================================
  public function updateCollisionTree(_dt:Float){
    for (i in 0...active_entities.length){
      active_entities.pop();
    }
    for (entity in entities){
      if(entity.active){
        active_entities.push(entity);
      }
    }
    collision_tree_manager.rebuild(active_entities);
  };

}
