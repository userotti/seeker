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

    //chird of the ore
    // var force_indicator = new Sprite({
    //   name: 'force_indicator',
    //   depth: 12,
    //   pos: new Vector(15,15),
    //   origin: new Vector(25+15,0+15),
    //   parent: pushable,
    //   scene: this,
    //   texture : Luxe.resources.texture('assets/images/rasters/force_indicator-01.png'),
    //   batcher: Luxe.renderer.batcher
    // });
    //
    // force_indicator.active = false;
    // force_indicator.visible = false;
    // //needs a force body
    // force_indicator.add(new ForceIndicatorComponent({name: ForceIndicatorComponent.TAG}));


    //force mekaar?

    // var force_field = new ForceFieldComponent({ name: ForceFieldComponent.TAG });
    // force_field.collision_tree_manager = this.collision_tree_manager;
    // pushable.add(force_field);

    return pushable;
  }

}
