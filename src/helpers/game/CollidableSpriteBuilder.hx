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
import components.utility.ForceIndicatorComponent;
import components.tower.AppearanceComponent;
import luxe.structural.Pool;

import helpers.game.CollisionSceneManager;

//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class CollidableSpriteBuilder {

  public function new() {

  }

  //STATIC TOWERS ===================================================
  public function setStaticTower (_static_tower:Sprite, _pos:Vector, _texture:String){

    _static_tower.init();
    _static_tower.visible = true;
    _static_tower.active = true;
    _static_tower.pos = new Vector(_pos.x,_pos.y);
    setStaticTowerAppearance(_static_tower, _texture);

  }

  public function setStaticTowerAppearance(_static_tower : Sprite, _texture: String){

    _static_tower.depth = 10;
    var wa = Luxe.resources.texture("assets/images/rasters/"+_texture).width_actual;
    var w = Luxe.resources.texture("assets/images/rasters/"+_texture).width;
    _static_tower.size = new Vector(wa,wa);
    _static_tower.origin = new Vector(w/2,w/2);
    _static_tower.texture = Luxe.resources.texture("assets/images/rasters/"+_texture);

  }

  public function setStaticTowerStats(_static_tower : Sprite, _forceFieldRadius: Float, _forceFieldForce: Float){

    _static_tower.get(ForceFieldComponent.TAG).setup(_forceFieldRadius, _forceFieldForce);//radius, constant_force

  }

  //TOWERS =================================================
  public function setTower(_tower:Sprite, _pos:Vector, _texture:String){

    var indicator_component = _tower.get(ForceIndicatorComponent.TAG, true);
    indicator_component.init();
    indicator_component.indicator.active = true;
    _tower.init();
    _tower.pos = _pos;
    _tower.active = true;
    _tower.visible = true;
    setTowerAppearance(_tower, _texture);

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

    _tower.get(CooldownComponent.TAG).setup(4.8);
    _tower.get(FrictionComponent.TAG).setup(50);

  }

  public function setTowerStats(_tower : Sprite, _break: Float, _boostpower:Float, _maxFuel:Float, _fuelRecharge:Float, _forceFieldRadius: Float, _forceFieldForce: Float){

    _tower.get(BreakComponent.TAG).setup(_break);
    _tower.get(BoostComponent.TAG).setup(_boostpower, _maxFuel, _fuelRecharge); //boostpower, top_speed, max_fuel, fuel_recharge
    _tower.get(ForceFieldComponent.TAG).setup(_forceFieldRadius, _forceFieldForce);//radius, constant_force

  }

  //PUSAHBLES ===========================================
  public function setPushable (_pushable : Sprite, _pos:Vector){

    var indicator_component = _pushable.get(ForceIndicatorComponent.TAG, true);
    indicator_component.init();
    indicator_component.indicator.active = true;
    _pushable.init();
    _pushable.pos = _pos;
    _pushable.active = true;
    _pushable.visible = true;

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
