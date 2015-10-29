package pools;


import luxe.Scene;
import luxe.Entity;
import luxe.structural.Pool;
import components.tower.*;
import components.effects.*;

import sprites.game.*;

class  FloaterPool extends Pool<TextureSprite>{

  private var scene : Scene;

  public function new(_size:Int, _scene:Scene){
    scene = _scene;
    super(_size, buildFloater);
  }

  public function buildFloater (index: Int, total: Int){

    var floater = new TextureSprite({
      name: 'floater'+index,
      scene: scene,
      batcher: Luxe.renderer.batcher
    });

    floater.active = false;
    floater.visible = false;
    floater.add(new MovementComponent({ name: MovementComponent.TAG }));
    floater.add(new TimedKillComponent({ name: TimedKillComponent.TAG }));

    return floater;
  }

}
