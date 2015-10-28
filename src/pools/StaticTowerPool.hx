package pools;

import luxe.Scene;
import luxe.structural.Pool;
import components.tower.*;
import sprites.game.*;


class  StaticTowerPool extends Pool<CollidableSprite>{

  private var scene : Scene;

  public function new(_size:Int, _scene:Scene){
    scene = _scene;
    super(_size, buildStaticTower);

  }

  //STATIC TOWERS ===================================================
  public function buildStaticTower(_index:Int, _total:Int) {
    var static_tower = new CollidableSprite({
      name: 'static_tower' + _index,
      scene: scene,
      centered: true,
      batcher: Luxe.renderer.batcher
    });

    static_tower.visible = false;
    static_tower.active = false;
    static_tower.add(new ForceFieldComponent({ name: ForceFieldComponent.TAG }));

    return static_tower;
  }

}
