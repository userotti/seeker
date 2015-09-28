package components.hud;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;

import components.tower.TowerBoostComponent;
import components.tower.TowerMovementComponent;



class MovementStatBarComponent extends Component {

  private var TAG = 'MovementStatBarComponent';
  private var full : Float;
  private var tower : Visual;
  private var statbar : Sprite;

  private var boost_component : TowerBoostComponent;
  private var movement_component : TowerMovementComponent;


  public function new(json:Dynamic) {
    super(json);
    full = 180;
  }

  override function init() {
    statbar = cast entity;
    statbar.size.x = -5;
    statbar.size.y = 50;


  } //init

  override function update(dt:Float) {
    statbar.rotation_z = 90 + (movement_component.velocity.length / 1000) * full;
  } //update

  public function setTower(entityName:String){
    boost_component = cast Luxe.scene.entities.get(entityName).get('boost');
    movement_component = cast Luxe.scene.entities.get(entityName).get('movement');

  }
}
