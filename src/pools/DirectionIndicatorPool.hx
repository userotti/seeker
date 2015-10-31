package pools;


import luxe.Scene;
import luxe.Entity;
import luxe.structural.Pool;
import components.tower.*;
import components.effects.*;

import sprites.game.*;

class  DirectionIndicatorPool extends Pool<TextureSprite>{

  private var scene : Scene;

  public function new(_size:Int, _scene:Scene){
    scene = _scene;
    super(_size, buildDirectionIndicator);
  }

  public function buildDirectionIndicator (index: Int, total: Int){

    var direction_indicator = new TextureSprite({
      name: 'direction_indicator'+index,
      scene: scene,
      batcher: Luxe.renderer.batcher
    });

    direction_indicator.active = false;
    direction_indicator.visible = false;
    direction_indicator.add(new HoverComponent({ name: HoverComponent.TAG }));
    direction_indicator.add(new DirectionIndicatorComponent({ name: DirectionIndicatorComponent.TAG }));
    
    return direction_indicator;
  }

}
