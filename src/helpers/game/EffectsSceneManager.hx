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
import components.effects.*;
import components.tower.AppearanceComponent;
import luxe.structural.Pool;

import sprites.game.*;
import pools.*;


class EffectsSceneManager extends Scene {

  public var floater_pool: FloaterPool;
  public var indicator_pool: DirectionIndicatorPool;

  public function new() {
    super('effects_scene');
  }

  //FLOATER ====================================================
  public function setupFloaterPool(_floater_pool_size: Int){
    floater_pool = new FloaterPool(_floater_pool_size, this);
  };

  public function setupIndicatorPool(_indicator_pool_size: Int){
    indicator_pool = new DirectionIndicatorPool(_indicator_pool_size, this);
  };

  public function getFloater(){
    var f = floater_pool.get();
    f.visible = true;
    f.active = true;
    return f;
  }

  public function getIndicator(){
    var i = indicator_pool.get();
    i.visible = true;
    i.active = true;
    return i;
  }

  public function kill(_entity:TextureSprite){
    _entity.visible = false;
    _entity.active = false;
    for (child in _entity.children){
      kill(cast(child, TextureSprite));
    }
  }

  public function destroyContents(){
    for(entity in entities){
      kill(cast(entity, TextureSprite));
    }
    this.empty();
    floater_pool = null;
  }
}
