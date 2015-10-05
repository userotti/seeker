package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;
import luxe.collision.shapes.*;

class TowerHitBodyComponent extends Component {

  private var shape : Circle;
  private var tower : Visual;

  public function new(json:Dynamic){
    super(json);
    shape = new Circle(0,0,1);
  }

  override function init() {
    tower = cast entity;
    shape.position.x = tower.pos.x;
    shape.position.y = tower.pos.y;
    shape.scaleX = 10;
    shape.scaleY = 10;


  } //init

  override function update(dt:Float) {

  } //update


}
