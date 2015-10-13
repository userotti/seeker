package factories.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Sprite;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;


//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class LevelFactory {

  private var scene: Scene;
  public function new(_scene:Scene) {
    scene = _scene;
  }


  public function createBush(pos:Vector) {

    var int = Math.floor(Math.random()*3)+1;
    var title_sprite = new Sprite({
      pos: new Vector(pos.x,pos.y),
      depth: -10,
      visible: true,
      centered: true,
      texture : Luxe.resources.texture("assets/images/rasters/bushes-0"+ int +".png"),
      scene: scene,
      batcher: Luxe.renderer.batcher
    });
  }

  public function createBushes(amount_x:Int, amount_y:Int, start_x:Float, start_y:Float, distance_appart:Float, grid_offset:Float){
    for(i in 0...amount_x){
      for(j in 0...amount_y){
        this.createBush(new Vector(start_x + distance_appart*i + (Math.random()*grid_offset - grid_offset/2) ,start_y + distance_appart*j +(Math.random()*grid_offset - grid_offset/2)));
      }
    }
  }

}
