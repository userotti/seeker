package factories.game;

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
import components.tower.ForceManagerComponent;

import components.tower.TimedKillComponent;

import components.utility.ForceIndicatorManager;

import components.tower.AppearanceComponent;
import luxe.structural.Pool;

//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class TowerFactory {

  private var scene : Scene;
  private var force_manager : ForceManagerComponent;

  private var static_tower_pool: Pool<Sprite>;
  private var tower_pool: Pool<Sprite>;
  private var pushable_pool: Pool<Sprite>;
  private var floater_pool: Pool<Sprite>;





  public function new(_scene:Scene) {
    scene = _scene;
    force_manager = new ForceManagerComponent({name: 'force_manager'}, scene);

  }

  public function setupPools(_tower_pool_size: Int, _pushable_pool_size: Int, _static_tower_pool_size: Int, _floater_pool_size: Int){
    static_tower_pool = new Pool<Sprite>(_static_tower_pool_size, buildStaticTower);
    tower_pool = new Pool<Sprite>(_tower_pool_size, buildTower);
    pushable_pool = new Pool<Sprite>(_pushable_pool_size, buildPushable);
    floater_pool = new Pool<Sprite>(_floater_pool_size, buildFloater);
  }

  public function destroyPools(){
    tower_pool = null;
    pushable_pool = null;
    pushable_pool = null;
  }

  //STATIC TOWERS ===================================================
  public function createStaticTower (_pos:Vector, _texture:String){

    var static_tower = static_tower_pool.get();
    static_tower.init();
    static_tower.visible = true;
    static_tower.active = true;

    static_tower.pos = new Vector(_pos.x,_pos.y);
    setStaticTowerAppearance(static_tower, _texture);

    return static_tower;

  }

  public function setStaticTowerAppearance(_static_tower : Sprite, _texture: String){

    _static_tower.depth = 10;
    var wa = Luxe.resources.texture("assets/images/rasters/"+_texture).width_actual;
    var w = Luxe.resources.texture("assets/images/rasters/"+_texture).width;
    _static_tower.size = new Vector(wa,wa);
    _static_tower.origin = new Vector(w/2,w/2);
    _static_tower.texture = Luxe.resources.texture("assets/images/rasters/"+_texture);

  }

  public function setStaticTowerStats(_tower : Sprite, _forceFieldRadius: Float, _forceFieldForce: Float){

    _tower.get('forcefield').setup(_forceFieldRadius, _forceFieldForce);//radius, constant_force

  }

  public function buildStaticTower(_index:Int, _total:Int){
    var static_tower = new luxe.Sprite({
      name: 'static_tower' + _index,
      scene: scene,
      centered: true,
      batcher: Luxe.renderer.batcher
    });

    static_tower.visible = false;
    static_tower.active = false;
    static_tower.add(new ForceFieldComponent({ name: 'forcefield' }));

    return static_tower;
  }

  //TOWERS =================================================
  public function createTower(_pos:Vector, _texture:String){

    var tower = tower_pool.get();
    var indicator_component = tower.get('forceindicator', true);
    indicator_component.init();
    indicator_component.indicator.active = true;
    tower.init();
    tower.pos = _pos;
    tower.active = true;
    tower.visible = true;
    setTowerAppearance(tower, _texture);

    return tower;

  }

  public function setTowerAppearance(_tower : Sprite, _texture: String){

    _tower.depth = 9;
    var wa = Luxe.resources.texture("assets/images/rasters/"+_texture).width_actual;
    var w = Luxe.resources.texture("assets/images/rasters/"+_texture).width;
    _tower.size = new Vector(wa,wa);
    _tower.origin = new Vector(w/2,w/2);
    _tower.texture = Luxe.resources.texture("assets/images/rasters/"+_texture);

  }

  public function setTowerLevelAttributes(_tower : Sprite){

    _tower.get('cooldown').setup(4.8);
    _tower.get('friction').setup(50);

  }

  public function setTowerStats(_tower : Sprite, _break: Float, _boostpower:Float, _maxFuel:Float, _fuelRecharge:Float, _forceFieldRadius: Float, _forceFieldForce: Float){

    _tower.get('break').setup(_break);
    _tower.get('boost').setup(_boostpower, _maxFuel, _fuelRecharge); //boostpower, top_speed, max_fuel, fuel_recharge
    _tower.get('forcefield').setup(_forceFieldRadius, _forceFieldForce);//radius, constant_force

  }

  public function buildTower (index: Int, total: Int) : Sprite{
    var tower = new luxe.Sprite({
      name: 'tower' + index,
      scene: scene,
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
    boost_component.tower_factory_reference = this;
    tower.add(boost_component);


    //needs boost
    tower.add(new AppearanceComponent({ name: 'appearance' }));
    tower.add(force_manager);
    //needs a force manager //Askes the force manager to push him around.
    tower.add(new ForceBodyComponent({ name: 'forcebody' }));
    //doesnt need a forcemanager
    tower.add(new ForceFieldComponent({ name: 'forcefield' }));

    var force_indicator = new Sprite({
      name: 'force_indicator',
      depth: 12,
      pos: new Vector(32.5,32.5), //the parent (w/2, w/2)
      origin: new Vector(50,15), // (distance from the center, indicator w/2)
      texture : Luxe.resources.texture('assets/images/rasters/force_indicator-01.png'),
      parent: tower,
      scene: scene,
      batcher: Luxe.renderer.batcher
    });

    force_indicator.active = false;
    force_indicator.visible = false;
    //needs a force body
    force_indicator.add(new ForceIndicatorManager({name: 'forceindicator'}));

    return tower;
  }


  //PUSAHBLES ===========================================
  public function createPushable (_pos:Vector) : Sprite{

    var fresh_pushable = pushable_pool.get();
    var indicator_component = fresh_pushable.get('forceindicator', true);
    indicator_component.init();
    indicator_component.indicator.active = true;

    fresh_pushable.init();
    fresh_pushable.pos = _pos;
    fresh_pushable.active = true;
    fresh_pushable.visible = true;

    return fresh_pushable;

  }

  public function setPushableAppearance(_pushable : Sprite, _texture: String){

    _pushable.depth = 9;
    _pushable.rotation_z = Math.random()*360;
    var wa = Luxe.resources.texture("assets/images/rasters/"+_texture).width_actual;
    var w = Luxe.resources.texture("assets/images/rasters/"+_texture).width;
    _pushable.size = new Vector(wa,wa);
    _pushable.origin = new Vector(w/2,w/2);
    _pushable.texture = Luxe.resources.texture("assets/images/rasters/"+_texture);

  }

  public function buildPushable (index: Int, total: Int){

    var pushable = new luxe.Sprite({
      name: 'pushable'+index,
      depth: 7,
      scene: scene,
      batcher: Luxe.renderer.batcher
    });

    pushable.active = false;
    pushable.visible = false;

    pushable.add(new MovementComponent({ name: 'movement' }));
    //needs movement component
    pushable.add(new AccelerationComponent({ name: 'acceleration' }));
    //needs movement component and Acceleration Componenets
    pushable.add(new FrictionComponent({ name: 'friction' }));
    pushable.add(force_manager);
    //needs a force manager
    pushable.add(new ForceBodyComponent({ name: 'forcebody' }));

    //chird of the ore
    var force_indicator = new Sprite({
      name: 'force_indicator',
      depth: 12,
      pos: new Vector(15,15),
      origin: new Vector(25+15,0+15),
      parent: pushable,
      scene: scene,
      texture : Luxe.resources.texture('assets/images/rasters/force_indicator-01.png'),
      batcher: Luxe.renderer.batcher
    });

    force_indicator.active = false;
    force_indicator.visible = false;
    //needs a force body
    force_indicator.add(new ForceIndicatorManager({name: 'forceindicator'}));

    return pushable;
  }

  //FLOATERS ===========================================
  public function createFloater (_pos:Vector, _vel:Vector, _lifetime:Float, _texture:String) : Sprite{

    var floater = floater_pool.get();

    floater.init();
    floater.pos = _pos;
    floater.active = true;
    floater.visible = true;

    floater.depth = 6;
    floater.rotation_z = Math.random()*360;
    var wa = Luxe.resources.texture("assets/images/rasters/"+_texture).width_actual;
    var w = Luxe.resources.texture("assets/images/rasters/"+_texture).width;
    floater.size = new Vector(wa,wa);
    floater.origin = new Vector(w/2,w/2);
    floater.texture = Luxe.resources.texture("assets/images/rasters/"+_texture);

    floater.get('movement').velocity = _vel;

    floater.get('timedkill').init();
    floater.get('timedkill').setup(_lifetime);

    return floater;

  }

  public function buildFloater (index: Int, total: Int){

    var floater = new luxe.Sprite({
      name: 'floater'+index,
      scene: scene,
      batcher: Luxe.renderer.batcher
    });

    floater.active = false;
    floater.visible = false;

    floater.add(new MovementComponent({ name: 'movement' }));
    floater.add(new TimedKillComponent({ name: 'timedkill' }));

    return floater;
  }

  public function kill(_tower:Sprite){

    _tower.active = false;
    _tower.visible = false;
    // _tower.scene = null;
    // scene.remove(_tower);

  }

}
