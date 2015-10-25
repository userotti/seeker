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
import helpers.game.CollisionTreeManager;

class ForceFieldComponent extends Component implements QuadtreeElement{

  private var shape : Circle;
  public var radius : Float;
  private var tower : Visual;
  public var constant_force : Float;
  public var collision_tree_manager : CollisionTreeManager;

  private var bounding_box : Box;

  private var my_collisions : Array<QuadtreeElement>;


  private var utility_vector : Vector;
  public function new(json:Dynamic){
    super(json);
    utility_vector = new Vector(0,0);
    radius = 0;
    constant_force = 0;
    bounding_box = new Box(0,0,0,0);
    my_collisions = new Array();
  }

  override function init() {
    tower = cast entity;

  } //init

  override function update(dt:Float) {


    bounding_box.x = Std.int(tower.pos.x-(bounding_box.width/2));
    bounding_box.y = Std.int(tower.pos.y-(bounding_box.height/2));

    my_collisions = (collision_tree_manager.collision_tree.getCollision(this.bounding_box));
    for(collision in my_collisions){
      var component = cast(collision, Component);
      if ((component.entity.name != this.entity.name) && (component.name == 'forcebody_collisionbox')){
        force(cast(component, ForceBodyComponent));
      }
    }

  }; //update

  public function circleCollision(_body:ForceBodyComponent){
    if (Math.abs(_body.pos.x - this.pos.x) < this.radius){
      if (Math.abs(_body.pos.y - this.pos.y) < this.radius){
        if ((Math.pow(_body.pos.x - this.pos.x, 2) + Math.pow(_body.pos.y - this.pos.y, 2)) < Math.pow(_body.radius - this.radius, 2)){
          return true;
        }
      }
    }
    return false;
  };

  public function force(body:ForceBodyComponent) {
    if (circleCollision(body)){
      utility_vector.x = body.pos.x - pos.x;
      utility_vector.y = body.pos.y - pos.y;

      utility_vector.normalize();
      utility_vector.multiplyScalar(constant_force);
      body.being_forced = true;
      body.total_force.add(utility_vector);
    };
  } //update

  public function setup (_r:Float, _f:Float){
    setRadius(_r);
    setForce(_f);
  }
  public function setRadius(_r:Float){
    radius = _r;
    bounding_box.width = Std.int(_r*2);
    bounding_box.height = Std.int(_r*2);

  }

  public function setForce(_f:Float){
    constant_force = _f;

  }

  public function box(){
    return bounding_box;
  }

}
