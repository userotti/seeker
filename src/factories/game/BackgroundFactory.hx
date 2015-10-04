package factories.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import phoenix.Batcher;
import phoenix.Camera;



class BackgroundFactory {

  private var background_batcher : Batcher;
  private var background_view : Camera;
  private var scene : Scene;

  //Constructor
  public function new(_scene : Scene) {

    scene = _scene;
    background_batcher = new Batcher(Luxe.renderer, 'background_batcher');
    var background_view = new Camera();
    background_batcher.view = background_view;
    background_batcher.layer = -1;
    Luxe.renderer.add_batch(background_batcher);

  } //init

  //Builder Functions
  public function createBackdrop (_color:Color){
    var shape = new luxe.Visual({
      pos: new Vector(0,0),
      visible: true,
      scale: new Vector(1,1),
      scene: scene
    });

    var basic_geo = new phoenix.geometry.Geometry({
      id: 'basic_geo',
      primitive_type: 4,
      visible: true,
      batcher: background_batcher
    });

    basic_geo.add(new Vertex(new Vector(0,0,0)));
    basic_geo.add(new Vertex(new Vector(Luxe.screen.w,0,0)));
    basic_geo.add(new Vertex(new Vector(Luxe.screen.w,Luxe.screen.h,0)));

    basic_geo.add(new Vertex(new Vector(0,Luxe.screen.h,0)));
    basic_geo.add(new Vertex(new Vector(0,0,0)));
    basic_geo.add(new Vertex(new Vector(Luxe.screen.w,Luxe.screen.h,0)));

    shape.geometry = basic_geo;
    shape.geometry.color = _color;

  }

  //This does not get called on seen change, the objects only ever gets built once. Main.hx onReady()
  public function destory() {
    background_batcher.destroy();
    background_view = null;
    Luxe.renderer.remove_batch(background_batcher);

  }

}
