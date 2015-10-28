package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.Entity;

import components.tower.ForceBodyComponent;

import luxe.Color;
import luxe.collision.shapes.*;
import com.elnabo.quadtree.*;

import sprites.game.*;

class ForceFieldComponent extends Component implements QuadtreeElement{

  public static var TAG = 'ForceFieldComponent';

  public var big_radius : Float;
  public var small_radius : Float;

  private var tower : CollidableSprite;
  public var constant_force : Float;
  private var bounding_box : Box;
  private var my_collisions : Array<QuadtreeElement>;

  private var utility_vector : Vector;
  public function new(json:Dynamic){
    super(json);
    utility_vector = new Vector(0,0);
    big_radius = 0;
    small_radius = 0;

    constant_force = 0;
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

    my_collisions = (tower.collision_tree.collision_tree.getCollision(this.bounding_box));

    for(collision in my_collisions){
      var component = cast(collision, Component);
      if ((component.entity.name != this.entity.name) && (component.name == ForceBodyComponent.TAG)){
        force(cast(component, ForceBodyComponent));
      }
    }

  }; //update

  public function circleCollision(_radius:Float, _body:ForceBodyComponent){
    if ((Math.pow(_body.pos.x - this.pos.x, 2) + Math.pow(_body.pos.y - this.pos.y, 2)) < Math.pow(_body.hit_radius - _radius, 2)){
      return true;
    }
    return false;
  };

  public function force(body:ForceBodyComponent) {
    if (circleCollision(big_radius, body)){
      if (!circleCollision(small_radius, body)){
        utility_vector.x = body.pos.x - pos.x;
        utility_vector.y = body.pos.y - pos.y;

        utility_vector.normalize();
        utility_vector.multiplyScalar(constant_force);
        body.being_forced = true;
        body.total_force.add(utility_vector);
      }
    };
  } //update

  public function setup (_big_radius:Float, _small_radius:Float, _f:Float){
    setRadius(_big_radius, _small_radius);
    setForce(_f);
  }
  public function setRadius(_br:Float,_sr:Float){
    big_radius = _br;
    small_radius = _sr;


  }

  public function setForce(_f:Float){
    constant_force = _f;
  }

  public function box(){
    return bounding_box;
  }

}
