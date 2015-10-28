package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;

import com.elnabo.quadtree.*;
import helpers.game.CollisionSceneManager;
import helpers.game.EffectsSceneManager;

import helpers.game.EffectBuilder;


class DefenceComponent extends Component implements QuadtreeElement{

  public static var TAG = 'DefenceComponent';

  public var hull : Float;
  public var max_hull : Float;
  public var tower : Sprite;
  public var hit_radius: Float;
  private var bounding_box : Box;

  public function new(json:Dynamic){
    super(json);
    bounding_box = new Box(0,0,0,0);
  }
  override function init() {
    tower = cast(this.entity, Sprite);
    bounding_box.width = Std.int(hit_radius*2);
    bounding_box.height = Std.int(hit_radius*2);
  } //init

  override function update(dt:Float) {
    bounding_box.x = Std.int(tower.pos.x-(hit_radius));
    bounding_box.y = Std.int(tower.pos.y-(hit_radius));


  } //update

  public function kap(_damage:Float){

    hull = hull - _damage;
    if (hull <= 0){

      for(i in 1...50){
        //fire effect event
        //EffectBuilder.makeFloater(effects_scene_manager.getFloater(), new Vector(tower.pos.x,tower.pos.y), new Vector((Math.random()*240) - 120,(Math.random()*240) - 120), 1.5, 'smoke_triangle-01.png', 6);
      }

      //collision_scene_manager.kill(this.tower);
    }

  }

  public function setup(_hit_radius:Float, _max_hull:Float) {


    max_hull = _max_hull;
    hull = max_hull;

    hit_radius = _hit_radius;


  } //init

  public function box(){
    return bounding_box;
  }

}
