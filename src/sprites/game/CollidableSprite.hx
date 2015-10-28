package sprites.game;

import luxe.Sprite;
import luxe.Vector;
import helpers.game.CollisionTreeManager;


class CollidableSprite extends TextureSprite{

  public var collision_tree: CollisionTreeManager;

  public function new(_json:Dynamic) {
    super(_json);
  };


}
