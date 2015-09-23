package factories;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import components.hud.MovementStatBarComponent;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import phoenix.Batcher;
import phoenix.Camera;



class HudFactory {

  private var hud_batcher : Batcher;
  private var hud_view : Camera;


  public function new() {


    hud_batcher = new Batcher(Luxe.renderer, 'hud_batcher');
    var hud_view = new Camera();
    hud_batcher.view = hud_view;
    hud_batcher.layer = 2;
    Luxe.renderer.add_batch(hud_batcher);

  } //init

  public function createStatBar (pos:Vector, color:Color, name:String){
    var bar = new luxe.Sprite({
      name: name,
      pos: pos,
      visible: true,
      scale: new Vector(1,1),
      centered: false,
      color: color,
      size: new Vector(1,1),
      batcher: hud_batcher
    });

    return bar;
  }

  public function createMovementStatBar (pos:Vector, color:Color){
    var bar = createStatBar(pos, color, 'movement_statbar');
    var component = new MovementStatBarComponent({
      name: 'movement_statbar_component'
    });
    bar.add(component);
    return bar;
  }
}
