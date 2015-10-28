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

import helpers.game.CollisionSceneManager;
import sprites.game.*;

//A Big List of presets build functions.
class LevelBuilder {

  //STATIC TOWERS ===================================================
  public static function makeMetalNest (_static_tower:TextureSprite, _pos:Vector){
    _static_tower.pos = _pos;
    _static_tower.resetTexture('metal_nest-01.png', 10);
    _static_tower.get(ForceFieldComponent.TAG).setup(200, 50, 200);
  }

  //TOWERS =================================================
  public static function makeMinorRedHexGrunt(_tower:TextureSprite, _pos:Vector){
    _tower.pos = _pos;
    _tower.rotation_z = Math.random()*360;
    _tower.resetTexture('metal_guy_red-01.png',8);
    _tower.get(CooldownComponent.TAG).setup(4.8);
    _tower.get(FrictionComponent.TAG).setup(50);
    _tower.get(BreakComponent.TAG).setup(50);
    _tower.get(BoostComponent.TAG).setup(310, 140000, 1500); //boostpower, top_speed, max_fuel, fuel_recharge
    _tower.get(ForceBodyComponent.TAG).setup(1); //hit_radius
    _tower.get(ForceFieldComponent.TAG).setup(150, 50, 200); //bigradius, small_radius constant_force
    _tower.get(DefenceComponent.TAG).setup(2, 100); //bigradius, max_hull
    _tower.get(OffenceComponent.TAG).setup(300, 50, 5, 100); //bigradius, small_radius, damage, reload

  }

  public static function makeMinorGreenRectGrunt(_tower:TextureSprite, _pos:Vector){
    _tower.pos = _pos;
    _tower.rotation_z = Math.random()*360;
    _tower.resetTexture('metal_guy_green-01.png',8);
    _tower.get(CooldownComponent.TAG).setup(4.8);
    _tower.get(FrictionComponent.TAG).setup(50);
    _tower.get(BreakComponent.TAG).setup(200);
    _tower.get(BoostComponent.TAG).setup(310, 140000, 1500); //boostpower, top_speed, max_fuel, fuel_recharge
    _tower.get(ForceBodyComponent.TAG).setup(1); //hit_radius
    _tower.get(ForceFieldComponent.TAG).setup(150, 50, 200); //bigradius, small_radius constant_force
    _tower.get(DefenceComponent.TAG).setup(2, 100); //bigradius, max_hull
    _tower.get(OffenceComponent.TAG).setup(100, 50, 1, 100); //bigradius, small_radius, damage, reload

  }

  public static function makeMinorBlueTriGrunt(_tower:TextureSprite, _pos:Vector){
    _tower.pos = _pos;
    _tower.rotation_z = Math.random()*360;
    _tower.resetTexture('metal_guy-01.png',8);
    _tower.get(CooldownComponent.TAG).setup(4.8);
    _tower.get(FrictionComponent.TAG).setup(50);
    _tower.get(BreakComponent.TAG).setup(200);
    _tower.get(BoostComponent.TAG).setup(410, 20000, 1500); //boostpower, top_speed, max_fuel, fuel_recharge
    _tower.get(ForceBodyComponent.TAG).setup(1);//hit_radius
    _tower.get(ForceFieldComponent.TAG).setup(200, 50, 200);//bigradius, small_radius constant_force
    _tower.get(DefenceComponent.TAG).setup(2, 100);//bigradius, small_radius
    _tower.get(OffenceComponent.TAG).setup(200, 50, 25, 100);//bigradius, small_radius, , ddudeamage, reload
  }

  //PUSAHBLES ===========================================
  public static function makeOre(_tower:TextureSprite, _pos:Vector){
    _tower.pos = _pos;
    _tower.rotation_z = Math.random()*360;
    _tower.resetTexture('yellow_ore-01.png', 9);
    _tower.get(FrictionComponent.TAG).setup(100);
    _tower.get(ForceBodyComponent.TAG).setup(1);
  }

  public static function makeOrePatch(_amount:Int, _w:Int, _h:Int, _pos:Vector, csm:CollisionSceneManager){
    for(i in 0..._amount){
      makeOre(csm.getPushable(), new Vector(_pos.x+(Math.random()*_w) + _w/2, _pos.y+(Math.random()*_h) - _h/2));
    };
  }




}
