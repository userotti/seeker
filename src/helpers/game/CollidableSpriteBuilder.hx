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
import components.tower.ForceManagerComponent;

import components.tower.TimedKillComponent;
import components.utility.ForceIndicatorManager;
import components.tower.AppearanceComponent;
import luxe.structural.Pool;

import helpers.game.CollisionSceneManager;

//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class CollidableSpriteBuilder {

  private var scene_manager : CollisionSceneManager;

  public function new(_sceneManager:CollisionSceneManager) {
    scene_manager = _sceneManager;
  }

  //STATIC TOWERS ===================================================
  public function createStaticTower (_pos:Vector, _texture:String){

    var static_tower = scene_manager.static_tower_pool.get();
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

  //TOWERS =================================================
  public function createTower(_pos:Vector, _texture:String){

    var tower = scene_manager.tower_pool.get();
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

  //PUSAHBLES ===========================================
  public function createPushable (_pos:Vector) : Sprite{

    var fresh_pushable = scene_manager.pushable_pool.get();
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

}
