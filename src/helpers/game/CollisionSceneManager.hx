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

class CollisionSceneManager extends Scene {

  public var collision_tree_manager : CollisionTreeManager;
  public var effects_scene_manager : EffectsSceneManager;
  public var static_tower_pool : Pool<TextureSprite>;
  public var tower_pool : Pool<TextureSprite>;
  public var pushable_pool : Pool<TextureSprite>;
  public var active_entities : Array<Entity>;

  public function new(_effects_scene_manager:EffectsSceneManager) {
    super('collision_scene');
    effects_scene_manager = _effects_scene_manager;
    collision_tree_manager = new CollisionTreeManager();
    active_entities = new Array<Entity>();
  };

  public function getStaticTower() : TextureSprite{
    var st = static_tower_pool.get();
    st.active = true;
    st.visible = true;
    return st;
  };

  public function getTower() : TextureSprite{
    var t = tower_pool.get();
    t.active = true;
    t.visible = true;
    return t;
  };

  public function getPushable() : TextureSprite{
    var p = pushable_pool.get();
    p.active = true;
    p.visible = true;
    return p;
  };

  public function kill(_entity:Sprite){
    _entity.active = false;
    _entity.visible = false;
    collision_tree_manager.removeEntity(_entity);

    for (child in _entity.children){
      kill(cast(child, Sprite));
    }
  }

  //SETUP POOLS ====================================================
  public function setupStaticTowerPool(_static_tower_pool_size: Int){
    static_tower_pool = new Pool<TextureSprite>(_static_tower_pool_size, buildStaticTower);
  };

  public function setupTowerPool(_tower_pool_size: Int){
    tower_pool = new Pool<TextureSprite>(_tower_pool_size, buildTower);
  };

  public function setupPushablePool(_pushable_pool_size: Int){
    pushable_pool = new Pool<TextureSprite>(_pushable_pool_size, buildPushable);
  };

  //STATIC TOWERS ===================================================
  public function buildStaticTower(_index:Int, _total:Int){
    var static_tower = new TextureSprite({
      name: 'static_tower' + _index,
      scene: this,
      centered: true,
      batcher: Luxe.renderer.batcher
    });

    static_tower.visible = false;
    static_tower.active = false;
    var force_field = new ForceFieldComponent({ name: ForceFieldComponent.TAG });
    force_field.collision_tree_manager = this.collision_tree_manager;
    static_tower.add(force_field);

    return static_tower;
  }

  //TOWERS ===================================================
  public function buildTower (index: Int, total: Int){
    var tower = new TextureSprite({
      name: 'tower' + index,
      scene: this,
      batcher: Luxe.renderer.batcher,
    });

    tower.active = false;
    tower.visible = false;

    // The order of these components are very important
    // Stand alone
    tower.add(new CooldownComponent({ name: CooldownComponent.TAG }));
    tower.add(new MovementComponent({ name: MovementComponent.TAG }));
    //needs movement component
    tower.add(new AccelerationComponent({ name: AccelerationComponent.TAG }));
    //needs movement component and Acceleration Componenets
    tower.add(new FrictionComponent({ name: FrictionComponent.TAG }));
    tower.add(new BreakComponent({ name: BreakComponent.TAG }));
    //needs all of the above
    var boost_component = new BoostComponent({ name: BoostComponent.TAG });
    //needs to be able to create things...
    tower.add(boost_component);
    //needs boost
    tower.add(new AppearanceComponent({ name: AppearanceComponent.TAG }));

    //needs a force manager //Askes the force manager to push him around.
    tower.add(new ForceBodyComponent({ name: ForceBodyComponent.TAG }));
    //doesnt need a forcemanager
    var force_field = new ForceFieldComponent({ name: ForceFieldComponent.TAG });
    force_field.collision_tree_manager = this.collision_tree_manager;
    tower.add(force_field);


    var defence = new DefenceComponent({ name: DefenceComponent.TAG }, this);
    defence.effects_scene_manager = this.effects_scene_manager;
    tower.add(defence);

    var offence = new OffenceComponent({ name: OffenceComponent.TAG });
    offence.collision_tree_manager = this.collision_tree_manager;
    offence.effects_scene_manager = this.effects_scene_manager;
    tower.add(offence);

    // var force_indicator = new Sprite({
    //   name: 'force_indicator',
    //   depth: 12,
    //   pos: new Vector(32.5,32.5), //the parent (w/2, w/2)
    //   origin: new Vector(50,15), // (distance from the center, indicator w/2)
    //   texture : Luxe.resources.texture('assets/images/rasters/force_indicator-01.png'),
    //   parent: tower,
    //   scene: this,
    //   batcher: Luxe.renderer.batcher
    // });
    //
    // force_indicator.active = false;
    // force_indicator.visible = false;
    //needs a force body
    //force_indicator.add(new ForceIndicatorComponent({name: ForceIndicatorComponent.TAG}));

    return tower;
  }

  //PUSHABLES ===================================================
  public function buildPushable (index: Int, total: Int){

    var pushable = new TextureSprite({
      name: 'pushable'+index,
      depth: 7,
      scene: this,
      batcher: Luxe.renderer.batcher
    });

    pushable.active = false;
    pushable.visible = false;

    pushable.add(new MovementComponent({ name: MovementComponent.TAG }));
    //needs movement component
    pushable.add(new AccelerationComponent({ name: AccelerationComponent.TAG }));
    //needs movement component and Acceleration Componenets
    pushable.add(new FrictionComponent({ name: FrictionComponent.TAG }));
    //needs a force manager
    pushable.add(new ForceBodyComponent({ name: ForceBodyComponent.TAG }));

    //chird of the ore
    // var force_indicator = new Sprite({
    //   name: 'force_indicator',
    //   depth: 12,
    //   pos: new Vector(15,15),
    //   origin: new Vector(25+15,0+15),
    //   parent: pushable,
    //   scene: this,
    //   texture : Luxe.resources.texture('assets/images/rasters/force_indicator-01.png'),
    //   batcher: Luxe.renderer.batcher
    // });
    //
    // force_indicator.active = false;
    // force_indicator.visible = false;
    // //needs a force body
    // force_indicator.add(new ForceIndicatorComponent({name: ForceIndicatorComponent.TAG}));


    //force mekaar?

    // var force_field = new ForceFieldComponent({ name: ForceFieldComponent.TAG });
    // force_field.collision_tree_manager = this.collision_tree_manager;
    // pushable.add(force_field);

    return pushable;
  }


  public function destroyContents(){
    this.empty();
    static_tower_pool = null;
    tower_pool = null;
    pushable_pool = null;
  }

  public function updateCollisionTree(_dt:Float){
    populateActiveEntities();
    collision_tree_manager.rebuild(active_entities);
  };

  public function populateActiveEntities(){
    for (i in 0...active_entities.length){
      active_entities.pop();
    }

    for (entity in entities){
      if(entity.active){
        active_entities.push(entity);
      }
    }
  }

}
