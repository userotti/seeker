package pools;


import luxe.Scene;
import luxe.Entity;
import luxe.structural.Pool;
import components.tower.*;

import sprites.game.*;

class  PushablePool extends Pool<CollidableSprite>{

  private var scene : Scene;

  public function new(_size:Int, _scene:Scene){
    scene = _scene;
    super(_size, buildPushable);

  }

  //PUSHABLES ===================================================
  public function buildPushable (index: Int, total: Int){

    var pushable = new CollidableSprite({
      name: 'pushable'+index,
      depth: 7,
      scene: scene,
      batcher: Luxe.renderer.batcher
    });

    pushable.active = false;
    pushable.visible = false;

    pushable.add(new MovementComponent({ name: MovementComponent.TAG }));
    //needs movement component
    pushable.add(new AccelerationComponent({ name: AccelerationComponent.TAG }));
    //needs movement component and Acceleration Componenets
    pushable.add(new FrictionComponent({ name: FrictionComponent.TAG }));
    //needs a force manager
    pushable.add(new ForceBodyComponent({ name: ForceBodyComponent.TAG }));
    pushable.add(new MetaDataComponent({ name: MetaDataComponent.TAG }));

    return pushable;
  }

}
