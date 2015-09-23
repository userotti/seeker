package components.hud;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;

import components.tower.TowerMovementComponent;

class MovementStatBarComponent extends Component {

  private var TAG = 'MovementStatBarComponent';
  private var full : Float;
  private var tower : Visual;
  private var statbar : Sprite;

  private var movement_component : TowerMovementComponent;

  public function new(json:Dynamic) {
    super(json);
    full = -100;
  }

  override function init() {
    statbar = cast entity;
    statbar.size.x = 10;
    statbar.size.y = full;

  } //init

  override function update(dt:Float) {
    statbar.size.y = (movement_component.velocity.length / movement_component.top_speed) * full;
  } //update

  public function setTower(entityName:String){
    movement_component = cast Luxe.scene.entities.get(entityName).get('movement');
  }
}
