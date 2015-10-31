package components.effects;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Entity;

class HoverComponent extends Component {

  public static var TAG = 'HoverComponent';

  public var sprite : Sprite;
  public var hover_around_entity : Entity;


  public function new(json:Dynamic){
    super(json);
  }

  override function init() {
    sprite = cast entity;
  } //init

  override function update(dt:Float) {
    sprite.pos.x = hover_around_entity.pos.x;
    sprite.pos.y = hover_around_entity.pos.y;
  } //update

  public function setup(entity: Entity){
    hover_around_entity = entity;
    sprite.pos.x = hover_around_entity.pos.x;
    sprite.pos.y = hover_around_entity.pos.y;
  }
}
