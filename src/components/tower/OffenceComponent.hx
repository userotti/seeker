package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Entity;

import com.elnabo.quadtree.*;
import components.tower.DefenceComponent;
import sprites.game.*;

class OffenceComponent extends Component implements QuadtreeElement{

  public static var TAG = 'OffenceComponent';

  public var big_radius : Float;
  public var small_radius : Float;
  public var damage : Float;
  public var reload_speed : Float;
  public var reload_cooldown : Float;

  public var tower : CollidableSprite;
  private var bounding_box : Box;
  private var my_collisions : Array<QuadtreeElement>;
  private var utility_vector : Vector;

  public function new(json:Dynamic){
    super(json);
    utility_vector = new Vector(0,0);
    big_radius = 0;
    small_radius = 0;

    damage = 0;
    reload_speed = 0;
    reload_cooldown = 0;

    bounding_box = new Box(0,0,0,0);
    my_collisions = new Array();
  }

  override function init() {
    tower = cast entity;
    bounding_box.width = Std.int(big_radius*2);
    bounding_box.height = Std.int(big_radius*2);
  } //init

  override function update(dt:Float) {

    bounding_box.x = Std.int(tower.pos.x-(big_radius));
    bounding_box.y = Std.int(tower.pos.y-(big_radius));

    //this is just a performance check;
    if (reload_cooldown >= 100){
      my_collisions = (tower.collision_tree.collision_tree.getCollision(this.bounding_box));
      for(collision in my_collisions){
        var component = cast(collision, Component);
        if ((component.entity.name != this.entity.name) && (component.name == DefenceComponent.TAG)){

          //check again can't hit 2 naiers at once;
          if (reload_cooldown >= 100){
            attack(cast(component, DefenceComponent));
          }

        }
      }
    }else{
      if (reload_cooldown < 100){
        reload_cooldown = reload_cooldown + dt*reload_speed;
      }
    }

  }; //update

  public function circleCollision(_radius:Float, _body:DefenceComponent){
    if ((Math.pow(_body.pos.x - this.pos.x, 2) + Math.pow(_body.pos.y - this.pos.y, 2)) < Math.pow(_body.hit_radius - _radius, 2)){
      return true;
    }
    return false;
  };

  public function attack(body:DefenceComponent) {
    if (circleCollision(big_radius, body)){
      if (!circleCollision(small_radius, body)){

        body.kap(damage);
        reload_cooldown = 0;

        //fire effect event
        //EffectBuilder.makeFloater(effects_scene_manager.getFloater(), new Vector(tower.pos.x,tower.pos.y), new Vector(20,-20), 1.5, 'smoke_triangle-01.png', 6);

      }
    };
  } //update

  public function setup (_big_radius:Float, _small_radius:Float, _damage:Float, _reload_speed:Float){

    big_radius = _big_radius;
    small_radius = _small_radius;
    damage = _damage;
    reload_speed = _reload_speed;

  }

  public function box(){
    return bounding_box;
  }

}
