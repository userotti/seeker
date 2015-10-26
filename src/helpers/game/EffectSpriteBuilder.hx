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
import components.tower.TimedKillComponent;


//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class EffectSpriteBuilder {

  private var scene_manager: EffectsSceneManager;
  public function new(_sceneManager:EffectsSceneManager) {
    scene_manager = _sceneManager;
  }

  public function createFloater (_pos:Vector, _vel:Vector, _lifetime:Float, _texture:String) : Sprite{

    var floater = scene_manager.floater_pool.get();

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

    floater.get(MovementComponent.TAG).velocity = _vel;
    floater.get(TimedKillComponent.TAG).init();
    floater.get(TimedKillComponent.TAG).setup(_lifetime, 0);

    return floater;

  }

}
