package factories.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Entity;


import components.hud.MovementStatBarComponent;
import components.hud.CooldownStatBarComponent;
import components.hud.FuelStatBarComponent;
import components.hud.BreakStatBarComponent;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import phoenix.Batcher;
import phoenix.Camera;



class HudFactory {

  private var hud_batcher : Batcher;
  private var hud_view : Camera;
  private var scene : Scene;


  public function new(_scene :Scene) {

    scene = _scene;
    hud_batcher = new Batcher(Luxe.renderer, 'hud_batcher');
    var hud_view = new Camera();
    hud_batcher.view = hud_view;
    hud_batcher.layer = 2;
    Luxe.renderer.add_batch(hud_batcher);

    var FPS_couter = new FPS(hud_batcher);

  } //init

  public function createStatBar (pos:Vector, color:Color, name:String){
    return new luxe.Sprite({
      name: name,
      pos: pos,
      visible: true,
      scale: new Vector(1,1),
      centered: false,
      color: color,
      size: new Vector(1,1),
      batcher: hud_batcher,
      scene: scene
    });
  }

  public function createMovementStatBar (pos:Vector, color:Color){
    return createStatBar(pos, color, 'movement_statbar').add(new MovementStatBarComponent({
      name: 'movement_statbar_component'
    }));
  }

  public function createCooldownStatBar (pos:Vector, color:Color){
    return createStatBar(pos, color, 'cooldown_statbar').add(new CooldownStatBarComponent({
      name: 'cooldown_statbar_component'
    }));
  }

  public function createFuelStatBar (pos:Vector, color:Color){
    return createStatBar(pos, color, 'fuel_statbar').add(new FuelStatBarComponent({
      name: 'fuel_statbar_component'
    }));
  }

  public function createBreakStatBar (pos:Vector, on_color:Color, off_color:Color){
    return createStatBar(pos, on_color, 'break_statbar').add(new BreakStatBarComponent({
      name: 'break_statbar_component'
    }, on_color, off_color));
  }

  //This does not get called on seen change, the objects only ever gets built once. Main.hx onReady()
  public function destory() {
    hud_batcher.destroy();
    hud_view = null;
    Luxe.renderer.remove_batch(hud_batcher);

  }

}
