package factories.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;


//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class LevelFactory {

  private var scene: Scene;
  public function new(_scene:Scene) {
    scene = _scene;
  }

  public function createBasicBackgroundShape(scale:Vector, pos:Vector, color:Color) {
    var shape = new luxe.Visual({
      pos: new Vector(pos.x,pos.y),
      visible: true,
      scale: new Vector(scale.x,scale.y),
      scene: scene
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
