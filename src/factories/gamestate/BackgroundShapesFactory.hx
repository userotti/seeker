package factories.gamestate;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import phoenix.Batcher;
import phoenix.Camera;



class BackgroundShapesFactory {

  private var background_batcher : Batcher;
  private var background_view : Camera;

  public function new() {

    background_batcher = new Batcher(Luxe.renderer, 'background_batcher');
        //we then create a second camera for it, default options
    var background_view = new Camera();
        //then assign it
    background_batcher.view = background_view;
        //the default batcher is stored at layer 1, we want to be above it
    background_batcher.layer = -1;
        //the add it to the renderer
    Luxe.renderer.add_batch(background_batcher);



  } //init

  public function createBackdrop (color:Color){
    var shape = new luxe.Visual({
      pos: new Vector(0,0),
      visible: true,
      scale: new Vector(1,1),
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
    shape.geometry.color = color;
  }

  public function createBasicBackgroundShape(scale:Vector, pos:Vector, color:Color) {
    var shape = new luxe.Visual({
      pos: new Vector(pos.x,pos.y),
      visible: true,
      scale: new Vector(scale.x,scale.y),
    });

    var basic_geo = new phoenix.geometry.Geometry({
      id: 'basic_geo',
      primitive_type: 4,
      visible: true,
      batcher: Luxe.renderer.batcher
    });

    basic_geo.add(new Vertex(new Vector(0,0,0)));
    basic_geo.add(new Vertex(new Vector(1,0,0)));
    basic_geo.add(new Vertex(new Vector(1,1,0)));

    basic_geo.add(new Vertex(new Vector(0,1,0)));
    basic_geo.add(new Vertex(new Vector(0,0,0)));
    basic_geo.add(new Vertex(new Vector(1,1,0)));

    shape.geometry = basic_geo;
    shape.geometry.color = color;
  }

  public function createBackgroundShapeMatrix(amount_x:Int, amount_y:Int, start_x:Float, start_y:Float, distance_appart:Float, color:Color){
    for(i in 0...amount_x){
      for(j in 0...amount_y){
        this.createBasicBackgroundShape(new Vector(20,20), new Vector(start_x + distance_appart*i,start_y + distance_appart*j), color);
      }
    }
  }

}
