package pools;


import luxe.Scene;
import luxe.structural.Pool;
import components.tower.*;
import sprites.game.*;

class  TowerPool extends Pool<CollidableSprite>{

  private var scene : Scene;

  public function new(_size:Int, _scene:Scene){
    scene = _scene;
    super(_size, buildTower);
  }

  //TOWERS ===================================================
  public function buildTower (index: Int, total: Int){
    var tower = new CollidableSprite({
      name: 'tower' + index,
      scene: scene,
      batcher: Luxe.renderer.batcher,
    });

    tower.active = false;
    tower.visible = false;

    // The order of these components are very important
    // Stand alone
    tower.add(new CooldownComponent({ name: CooldownComponent.TAG }));
    tower.add(new MovementComponent({ name: MovementComponent.TAG }));
    //needs movement component
    tower.add(new AccelerationComponent({ name: AccelerationComponent.TAG }));
    //needs movement component and Acceleration Componenets
    tower.add(new FrictionComponent({ name: FrictionComponent.TAG }));
    tower.add(new BreakComponent({ name: BreakComponent.TAG }));
    //needs all of the above
    var boost_component = new BoostComponent({ name: BoostComponent.TAG });
    //needs to be able to create things...
    tower.add(boost_component);
    //needs boost
    tower.add(new AppearanceComponent({ name: AppearanceComponent.TAG }));

    //needs a force manager //Askes the force manager to push him around.
    tower.add(new ForceBodyComponent({ name: ForceBodyComponent.TAG }));
    //doesnt need a forcemanager
    var force_field = new ForceFieldComponent({ name: ForceFieldComponent.TAG });
    tower.add(force_field);

    var defence = new DefenceComponent({ name: DefenceComponent.TAG });
    tower.add(defence);

    var offence = new OffenceComponent({ name: OffenceComponent.TAG });
    tower.add(offence);

    // var force_indicator = new Sprite({
    //   name: 'force_indicator',
    //   depth: 12,
    //   pos: new Vector(32.5,32.5), //the parent (w/2, w/2)
    //   origin: new Vector(50,15), // (distance from the center, indicator w/2)
    //   texture : Luxe.resources.texture('assets/images/rasters/force_indicator-01.png'),
    //   parent: tower,
    //   scene: this,
    //   batcher: Luxe.renderer.batcher
    // });
    //
    // force_indicator.active = false;
    // force_indicator.visible = false;
    //needs a force body
    //force_indicator.add(new ForceIndicatorComponent({name: ForceIndicatorComponent.TAG}));

    return tower;
  }

}
