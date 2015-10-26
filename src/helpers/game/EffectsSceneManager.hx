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


class EffectsSceneManager extends Scene {

  public var effect_sprite_builder : EffectSpriteBuilder;
  public var floater_pool: Pool<Sprite>;


  public function new() {
    super('effects_scene');
    effect_sprite_builder = new EffectSpriteBuilder(this);
  }

  //FLOATER ====================================================
  public function setupFloaterPool(_floater_pool_size: Int){
    floater_pool = new Pool<Sprite>(_floater_pool_size, buildFloater);
  };

  public function buildFloater (index: Int, total: Int){

    var floater = new luxe.Sprite({
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
