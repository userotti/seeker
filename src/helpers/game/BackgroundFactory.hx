package helpers.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Sprite;

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

    var backdrop = new Sprite({
      pos: new Vector(0,0),
      centered: false,
      visible: true,
      texture : Luxe.resources.texture("assets/images/rasters/game_background_blue3.png"),
      scene: scene,
      batcher: background_batcher
    });

  }

  //This does not get called on seen change, the objects only ever gets built once. Main.hx onReady()
  public function destory() {
    background_batcher.destroy();
    background_view = null;
    Luxe.renderer.remove_batch(background_batcher);

  }

}
