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
    //needs to be able to create things...
    tower.add(new BoostComponent({ name: BoostComponent.TAG }));
    //needs boost
    tower.add(new AppearanceComponent({ name: AppearanceComponent.TAG }));
    //needs a force manager //Askes the force manager to push him around.
    tower.add(new ForceBodyComponent({ name: ForceBodyComponent.TAG }));
    //doesnt need a forcemanager
    tower.add(new ForceFieldComponent({ name: ForceFieldComponent.TAG }));
    tower.add(new DefenceComponent({ name: DefenceComponent.TAG }));
    tower.add(new OffenceComponent({ name: OffenceComponent.TAG }));
    tower.add(new MetaDataComponent({ name: MetaDataComponent.TAG }));


    return tower;
  }

}
