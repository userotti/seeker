package helpers.game;


import luxe.Entity;
import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Sprite;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import phoenix.geometry.Geometry;

import components.tower.MovementComponent;
import components.tower.MetaDataComponent;
import components.effects.*;

import helpers.game.EffectsSceneManager;

import sprites.game.*;

//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class EffectBuilder {

  public static function makeFloater (_floater: TextureSprite, _pos:Vector, _orgin:Vector, _vel:Vector, _rotation:Float, _lifetime:Float, _texture:String, _depth:Float){

    _floater.pos = _pos;
    _floater.rotation_z = _rotation;
    _floater.resetTexture(_texture, _depth);
    _floater.get(MovementComponent.TAG).velocity = _vel;
    _floater.get(TimedKillComponent.TAG).setup(_lifetime);
    _floater.origin = _orgin;

  }

  public static function makeIndicator (_indicator: TextureSprite, _follow:Entity, _direction_vector:Vector, _origin_x:Float, _texture:String, _depth:Int){


    _indicator.depth = _depth;
    _indicator.resetTexture(_texture, _depth);
    _indicator.get(HoverComponent.TAG).setup(_follow, _origin_x);
    _indicator.origin.x = _origin_x; // (distance from the center, indicator w/2)
    _indicator.rotation_z = (Math.atan2(_direction_vector.y, _direction_vector.x) / Math.PI) * 180;

  }

  public static function makeWeaponBlast (_target: TextureSprite, _attacker: TextureSprite, esm: EffectsSceneManager){

    if (_attacker.get(MetaDataComponent.TAG).type_name == 'tower'){
      makeFloater(esm.getFloater(),
      new Vector(_attacker.pos.x,_attacker.pos.y),
      new Vector(5,100), //origin
      new Vector(0,0), //velocity
      _attacker.pos.rotationTo(_target.pos),
      0.1,
      'blue_weapon_flame-01.png',
      12);

      makeFloater(esm.getFloater(),
      new Vector(_attacker.pos.x,_attacker.pos.y),
      new Vector(5,100), //origin
      new Vector(0,0), //velocity
      _attacker.pos.rotationTo(_target.pos),
      0.05,
      'blue_weapon_flame_short-01.png',
      12);

      for(i in 0...2){
        var rotation_to = _attacker.pos.rotationTo(_target.pos) - 90;
        var rotation_to_deviated = (rotation_to + Math.random()*100 - 50) / 180 * Math.PI;

        makeFloater(esm.getFloater(),
        new Vector(_attacker.pos.x + Math.cos((rotation_to / 180) * Math.PI)*30,_attacker.pos.y + Math.sin((rotation_to / 180)* Math.PI)*30),
        new Vector(0,0), //origin
        new Vector(Math.cos(rotation_to_deviated)*170,Math.sin(rotation_to_deviated)*170), //velocity
        (rotation_to_deviated/Math.PI) * 180,
        (Math.random()*0.1) + 0.1,
        'blue_weapon_smoke-01.png',
        12);

        makeFloater(esm.getFloater(),
        new Vector(_attacker.pos.x + Math.cos((rotation_to / 180) * Math.PI)*30,_attacker.pos.y + Math.sin((rotation_to / 180)* Math.PI)*30),
        new Vector(0,0), //origin
        new Vector(Math.cos(rotation_to_deviated)*30,Math.sin(rotation_to_deviated)*30), //velocity
        (rotation_to_deviated/Math.PI) * 180,
        (Math.random()*0.6) + 0.5,
        'smoke_triangle-01.png',
        12);
      }
    }

  }

  public static function makeHullHit (_target: TextureSprite, _attacker: TextureSprite, esm: EffectsSceneManager){

    if (_target.get(MetaDataComponent.TAG).type_name == 'tower'){
      makeFloater(esm.getFloater(),
      new Vector(_target.pos.x,_target.pos.y),
      new Vector(35,50), //origin
      new Vector(0,0), //velocity
      _target.pos.rotationTo(_attacker.pos),
      0.1,
      'blue_hit_bang-01.png',
      _target.depth-1);

      makeFloater(esm.getFloater(),
      new Vector(_target.pos.x,_target.pos.y),
      new Vector(35,50), //origin
      new Vector(0,0), //velocity
      _target.pos.rotationTo(_attacker.pos),
      0.05,
      'blue_hit_bang_top-01.png',
      12);

      for(i in 0...3){
        var rotation_to = _target.pos.rotationTo(_attacker.pos) - 90;
        var rotation_to_deviated = (rotation_to + Math.random()*150 - 75) / 180 * Math.PI;

        makeFloater(esm.getFloater(),
        new Vector(_target.pos.x + Math.cos((rotation_to / 180) * Math.PI)*10,_target.pos.y + Math.sin((rotation_to / 180)* Math.PI)*10),
        new Vector(0,0), //origin
        new Vector(Math.cos(rotation_to_deviated)*180,Math.sin(rotation_to_deviated)*180), //velocity
        (rotation_to_deviated/Math.PI) * 180,
        (Math.random()*0.2) + 0.1,
        'spark-01.png',
        12);

        makeFloater(esm.getFloater(),
        new Vector(_target.pos.x + Math.cos((rotation_to / 180) * Math.PI)*10,_target.pos.y + Math.sin((rotation_to / 180)* Math.PI)*10),
        new Vector(0,0), //origin
        new Vector(Math.cos(rotation_to_deviated)*30,Math.sin(rotation_to_deviated)*30), //velocity
        (rotation_to_deviated/Math.PI) * 180,
        (Math.random()*0.6) + 0.5,
        'smoke_triangle-01.png',
        12);
      }
    }
  }

  public static function makeTowerDestory (_dead_tower: TextureSprite, esm: EffectsSceneManager){
    for(i in 0...13){
      var random_angle = (Math.random()*360) / 180 * Math.PI;

      makeFloater(esm.getFloater(),
      new Vector(_dead_tower.pos.x, _dead_tower.pos.y),
      new Vector(0,0), //origin
      new Vector(Math.cos(random_angle)*180,Math.sin(random_angle)*180), //velocity
      (random_angle/Math.PI) * 180,
      (Math.random()*0.2) + 0.1,
      'spark-01.png',
      12);

    }
    for(i in 0...18){
      var random_angle = (Math.random()*360) / 180 * Math.PI;

      makeFloater(esm.getFloater(),
      new Vector(_dead_tower.pos.x,_dead_tower.pos.y),
      new Vector(0,0), //origin
      new Vector(Math.cos(random_angle)*Math.random()*20,Math.sin(random_angle)*Math.random()*20), //velocity
      (random_angle/Math.PI) * 180,
      (Math.random()*1.2) + 1.1,
      'smoke_triangle-01.png',
      12);

    }
  }



}
