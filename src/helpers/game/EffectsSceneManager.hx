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

class EffectsSceneManager extends Scene {

  public var floater_pool: Pool<TextureSprite>;

  public function new() {
    super('effects_scene');
  }

  //FLOATER ====================================================
  public function setupFloaterPool(_floater_pool_size: Int){
    floater_pool = new Pool<TextureSprite>(_floater_pool_size, buildFloater);
  };

  public function getFloater(){
    var f = floater_pool.get();
    f.visible = true;
    f.active = true;
    return f;
  }

  public function buildFloater (index: Int, total: Int){

    var floater = new TextureSprite({
      name: 'floater'+index,
      scene: this,
      batcher: Luxe.renderer.batcher
    });

    floater.active = false;
    floater.visible = false;
    floater.add(new MovementComponent({ name: MovementComponent.TAG }));
    floater.add(new TimedKillComponent({ name: TimedKillComponent.TAG }));

    return floater;
  }

  public function destroyContents(){
    this.empty();
    floater_pool = null;
  }
}
