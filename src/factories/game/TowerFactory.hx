package factories.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Entity;



import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;

import components.tower.TowerMovementComponent;
import components.tower.TowerAccelerationComponent;

import components.tower.TowerFrictionComponent;
import components.tower.TowerBoostComponent;
import components.tower.TowerBreakComponent;
import components.tower.TowerCooldownComponent;
import components.tower.TowerHitBodyComponent;




import components.tower.TowerAppearanceComponent;

//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class TowerFactory {

  private var scene : Scene;

  public function new(_scene:Scene) {
    scene = _scene;
  }

  public function setTowerAppearance(tower:luxe.Visual, tower_type:String){
    if (tower_type == 'red'){
      tower.geometry = this.makeBasicGeometry();
      tower.geometry.color = new Color().rgb(0xff4400);
    }
    if (tower_type == 'blue'){
      tower.geometry = this.makeBasicGeometry();
      tower.geometry.color = new Color().rgb(0x2266ee);
    }
  }

  public function setTowerStats(tower:Entity, tower_type:String){
    if (tower_type == 'basic'){
      tower.get('cooldown').setup(0.8);
      tower.get('friction').setup(50);
      tower.get('break').setup(200);
      tower.get('boost').setup(360, 270, 30000, 200); //boostpower, top_speed, max_fuel, fuel_recharge
    }
  }

  public function createTower (pos:Vector, name:String) : Visual{
    var tower = new luxe.Visual({
      name: name,
      pos: new Vector(pos.x,pos.y),
      visible: true,
      scale: new Vector(20,20),
      scene: scene
    });

    // The order of these components are very important
    // Stand alone
    tower.add(new TowerCooldownComponent({ name: 'cooldown' }));
    tower.add(new TowerMovementComponent({ name: 'movement' }));
    //needs movement component
    tower.add(new TowerAccelerationComponent({ name: 'acceleration' }));
    //needs movement component and Acceleration Componenets
    tower.add(new TowerFrictionComponent({ name: 'friction' }));
    tower.add(new TowerBreakComponent({ name: 'break' }));
    //needs all of the above
    tower.add(new TowerBoostComponent({ name: 'boost' }));
    //needs boost
    tower.add(new TowerAppearanceComponent({ name: 'appearance' }));
    tower.add(new TowerHitBodyComponent({ name: 'hitbody' }));



    return tower;

  }

  private function makeBasicGeometry() : Geometry {
    var basic_geo = new phoenix.geometry.Geometry({
      primitive_type: 4,
      visible: true,
      batcher: Luxe.renderer.batcher
    });

    basic_geo.add(new Vertex(new Vector(-1,-1,0)));
    basic_geo.add(new Vertex(new Vector(1,-1,0)));
    basic_geo.add(new Vertex(new Vector(1,1,0)));

    basic_geo.add(new Vertex(new Vector(-1,1,0)));
    basic_geo.add(new Vertex(new Vector(-1,-1,0)));
    basic_geo.add(new Vertex(new Vector(1,1,0)));

    return basic_geo;
  }

}
