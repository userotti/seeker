package helpers.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Entity;
import luxe.Sprite;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import components.tower.MovementComponent;
import components.tower.AccelerationComponent;
import components.tower.FrictionComponent;
import components.tower.BoostComponent;
import components.tower.BreakComponent;
import components.tower.CooldownComponent;
import components.tower.ForceBodyComponent;
import components.tower.ForceFieldComponent;

import components.tower.TimedKillComponent;
import components.utility.ForceIndicatorManager;
import components.tower.AppearanceComponent;
import luxe.structural.Pool;

import helpers.game.CollidableSpriteBuilder;
import helpers.game.CollisionTreeManager;


class CollisionSceneManager extends Scene {

  public var collision_tree_manager : CollisionTreeManager;

  public var effects_builder : EffectSpriteBuilder;
  public var static_tower_pool: Pool<Sprite>;
  public var tower_pool: Pool<Sprite>;
  public var pushable_pool: Pool<Sprite>;

  public var active_entities : Array<Entity>;

  public function new(_effect_sprite_builder:EffectSpriteBuilder) {
    super('collision_scene');
    effects_builder = _effect_sprite_builder;
    collision_tree_manager = new CollisionTreeManager();
    active_entities = new Array<Entity>();
  };

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


  public function getStaticTower() : Sprite{
    return static_tower_pool.get();
  };

  public function getTower() : Sprite{
    return tower_pool.get();
  };

  public function getPushable() : Sprite{
    return pushable_pool.get();
  };

  //SETUP POOLS ====================================================
  public function setupStaticTowerPool(_static_tower_pool_size: Int){
    static_tower_pool = new Pool<Sprite>(_static_tower_pool_size, buildStaticTower);
  };

  public function setupTowerPool(_tower_pool_size: Int){
    tower_pool = new Pool<Sprite>(_tower_pool_size, buildTower);
  };

  public function setupPushablePool(_pushable_pool_size: Int){
    pushable_pool = new Pool<Sprite>(_pushable_pool_size, buildPushable);
  };

  //STATIC TOWERS ===================================================
  public function buildStaticTower(_index:Int, _total:Int){
    var static_tower = new luxe.Sprite({
      name: 'static_tower' + _index,
      scene: this,
      centered: true,
      batcher: Luxe.renderer.batcher
    });

    static_tower.visible = false;
    static_tower.active = false;
    var force_field = new ForceFieldComponent({ name: 'forcefield_collisionbox' });
    force_field.collision_tree_manager = this.collision_tree_manager;
    static_tower.add(force_field);

    return static_tower;
  }

  //TOWERS ===================================================
  public function buildTower (index: Int, total: Int) : Sprite{
    var tower = new luxe.Sprite({
      name: 'tower' + index,
      scene: this,
      batcher: Luxe.renderer.batcher,
    });

    tower.active = false;
    tower.visible = false;

    // The order of these components are very important
    // Stand alone
    tower.add(new CooldownComponent({ name: 'cooldown' }));
    tower.add(new MovementComponent({ name: 'movement' }));
    //needs movement component
    tower.add(new AccelerationComponent({ name: 'acceleration' }));
    //needs movement component and Acceleration Componenets
    tower.add(new FrictionComponent({ name: 'friction' }));
    tower.add(new BreakComponent({ name: 'break' }));
    //needs all of the above
    var boost_component = new BoostComponent({ name: 'boost' });
    //needs to be able to create things...
    tower.add(boost_component);
    //needs boost
    tower.add(new AppearanceComponent({ name: 'appearance' }));

    //needs a force manager //Askes the force manager to push him around.
    tower.add(new ForceBodyComponent({ name: 'forcebody_collisionbox' }));
    //doesnt need a forcemanager
    var force_field = new ForceFieldComponent({ name: 'forcefield_collisionbox' });
    force_field.collision_tree_manager = this.collision_tree_manager;
    tower.add(force_field);


    var force_indicator = new Sprite({
      name: 'force_indicator',
      depth: 12,
      pos: new Vector(32.5,32.5), //the parent (w/2, w/2)
      origin: new Vector(50,15), // (distance from the center, indicator w/2)
      texture : Luxe.resources.texture('assets/images/rasters/force_indicator-01.png'),
      parent: tower,
      scene: this,
      batcher: Luxe.renderer.batcher
    });

    force_indicator.active = false;
    force_indicator.visible = false;
    //needs a force body
    force_indicator.add(new ForceIndicatorManager({name: 'forceindicator'}));

    return tower;
  }

  //PUSHABLES ===================================================
  public function buildPushable (index: Int, total: Int){

    var pushable = new luxe.Sprite({
      name: 'pushable'+index,
      depth: 7,
      scene: this,
      batcher: Luxe.renderer.batcher
    });

    pushable.active = false;
    pushable.visible = false;

    pushable.add(new MovementComponent({ name: 'movement' }));
    //needs movement component
    pushable.add(new AccelerationComponent({ name: 'acceleration' }));
    //needs movement component and Acceleration Componenets
    pushable.add(new FrictionComponent({ name: 'friction' }));
    //needs a force manager
    pushable.add(new ForceBodyComponent({ name: 'forcebody_collisionbox' }));

    //chird of the ore
    var force_indicator = new Sprite({
      name: 'force_indicator',
      depth: 12,
      pos: new Vector(15,15),
      origin: new Vector(25+15,0+15),
      parent: pushable,
      scene: this,
      texture : Luxe.resources.texture('assets/images/rasters/force_indicator-01.png'),
      batcher: Luxe.renderer.batcher
    });

    force_indicator.active = false;
    force_indicator.visible = false;
    //needs a force body
    force_indicator.add(new ForceIndicatorManager({name: 'forceindicator'}));

    return pushable;
  }


  public function destroyContents(){
    this.empty();
    static_tower_pool = null;
    tower_pool = null;
    pushable_pool = null;
  }
}
