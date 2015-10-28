package helpers.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Sprite;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import phoenix.geometry.Geometry;

import components.tower.MovementComponent;
import components.effects.*;

import sprites.game.*;

//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class EffectBuilder {

  public static function makeFloater (_floater: TextureSprite, _pos:Vector, _vel:Vector, _lifetime:Float, _texture:String, _depth:Int){

    _floater.pos = _pos;
    _floater.rotation_z = Math.random()*360;
    _floater.resetTexture(_texture, _depth);
    _floater.get(MovementComponent.TAG).velocity = _vel;
    _floater.get(TimedKillComponent.TAG).setup(_lifetime, 0);

  }

}
