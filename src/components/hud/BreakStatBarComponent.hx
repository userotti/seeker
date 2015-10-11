package components.hud;

import luxe.Component;
import luxe.Vector;
import luxe.Color;
import luxe.Sprite;
import luxe.Visual;
import luxe.Entity;


import components.tower.BreakComponent;

class BreakStatBarComponent extends Component {

  private static var TAG = 'BreakStatBarComponent';
  private var on_color : Color;
  private var off_color : Color;
  private var tower : Visual;
  private var statbar : Sprite;
  private var break_component : BreakComponent;

  public function new(json:Dynamic, onColor:Color, offColor:Color) {
    super(json);
    on_color = onColor;
    off_color = offColor;
  }

  override function init() {
    statbar = cast entity;
    statbar.size.x = 20;
    statbar.size.y = -20;
  } //init

  override function update(dt:Float) {
    if (break_component.breaking == true){
      statbar.color = off_color;
    }else{
      statbar.color = on_color;
    }

  } //update

  public function setTower(_tower:Entity){
    break_component = _tower.get('break');
  }
}
