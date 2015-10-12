package factories.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Entity;



import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;

import components.tower.MovementComponent;
import components.tower.AccelerationComponent;

import components.tower.FrictionComponent;
import components.tower.BoostComponent;
import components.tower.BreakComponent;
import components.tower.CooldownComponent;
import components.tower.ForceBodyComponent;
import components.tower.ForceFieldComponent;
import components.tower.ForceManagerComponent;




import components.tower.AppearanceComponent;

//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class TowerFactory {

  private var scene : Scene;
  private var force_manager : ForceManagerComponent;

  public function new(_scene:Scene) {
    scene = _scene;
    force_manager = new ForceManagerComponent({name: 'force_manager'}, scene);
  }

  public function setTowerAppearance(tower:luxe.Visual, tower_type:String){

  }

  public function createStilTower (pos:Vector, name:String) : Visual{
    var tower = new luxe.Visual({
      name: name,
      pos: new Vector(pos.x,pos.y),
      visible: true,
      scene: scene
    });

    tower.add(new ForceFieldComponent({ name: 'forcefield' }));
    var forcefield = tower.get('forcefield');
    forcefield.setup(200, -150);//radius, constant_force

    tower.geometry = this.makeCircleGeometry(25);
    tower.geometry.color = new Color().rgb(0xdd4433);

    var force_field = new luxe.Visual({
      name: name+"_force_field",
      parent: tower,
      visible: true,
      scene: scene
    });


    force_field.geometry = this.makeCircleGeometry(forcefield.radius);
    force_field.geometry.color = new Color().set(1,1,1,0.02);


    return tower;

  }

  public function createTower (pos:Vector, name:String) : Visual{
    var tower = new luxe.Visual({
      depth: 10,
      name: name,
      pos: new Vector(pos.x,pos.y),
      visible: true,
      scene: scene
    });

    // The order of these components are very important
    // Stand alone
    tower.add(new CooldownComponent({ name: 'cooldown' }));
    tower.add(new MovementComponent({ name: 'movement' }));
    //needs movement component
    tower.add(new AccelerationComponent({ name: 'acceleration' }));
    //needs movement component and Acceleration Componenets
    tower.add(new FrictionComponent({ name: 'friction' }));
    tower.add(new BreakComponent({ name: 'break' }));
    //needs all of the above
    tower.add(new BoostComponent({ name: 'boost' }));
    //needs boost
    tower.add(new AppearanceComponent({ name: 'appearance' }));

    tower.add(force_manager);
    //needs a force manager
    tower.add(new ForceBodyComponent({ name: 'forcebody' }));
    //doesnt nee a forcemanager
    tower.add(new ForceFieldComponent({ name: 'forcefield' }));

    tower.get('cooldown').setup(4.8);
    tower.get('friction').setup(50);
    tower.get('break').setup(200);
    tower.get('boost').setup(360, 270, 20000, 1500); //boostpower, top_speed, max_fuel, fuel_recharge

    var forcefield = tower.get('forcefield');
    forcefield.setup(150, 150);//radius, constant_force

    tower.geometry = this.makeBasicGeometry();
    tower.geometry.color = new Color().rgb(0xff4400);

    var force_field = new luxe.Visual({
      name: name+"_force_field",
      parent: tower,
      visible: true,
      scene: scene
    });

    force_field.geometry = this.makeCircleGeometry(forcefield.radius);
    force_field.geometry.color = new Color().set(1,1,1,0.02);


    return tower;

  }

  public function createRock (pos:Vector, name:String) : Visual{
    var rock = new luxe.Visual({
      name: name,
      pos: new Vector(pos.x,pos.y),
      visible: true,
      scene: scene
    });

    rock.add(new MovementComponent({ name: 'movement' }));
    // // //needs movement component
    rock.add(new AccelerationComponent({ name: 'acceleration' }));
    // //needs movement component and Acceleration Componenets
    rock.add(new FrictionComponent({ name: 'friction' }));

    rock.add(force_manager);
    // //needs a force manager
    rock.add(new ForceBodyComponent({ name: 'forcebody' }));
    rock.get('friction').setup(100);

    rock.geometry = this.makeCircleGeometry(Math.floor(Math.random()*10)+2);
    rock.geometry.color = new Color().rgb(0x888888);

    return rock;

  }

  private function makeBasicGeometry() : Geometry {
    var basic_geo = new phoenix.geometry.Geometry({
      primitive_type: 4,
      visible: true,
      batcher: Luxe.renderer.batcher
    });

    basic_geo.add(new Vertex(new Vector(-20,-20,0)));
    basic_geo.add(new Vertex(new Vector(20,-20,0)));
    basic_geo.add(new Vertex(new Vector(20,20,0)));

    basic_geo.add(new Vertex(new Vector(-20,20,0)));
    basic_geo.add(new Vertex(new Vector(-20,-20,0)));
    basic_geo.add(new Vertex(new Vector(20,20,0)));

    return basic_geo;
  }

  private function makeCircleGeometry(radius:Float) : Geometry {
    var basic_geo = new phoenix.geometry.CircleGeometry({
      primitive_type: 0,
      x: 0,
      y: 0,
      r: radius,
      visible: true,
      batcher: Luxe.renderer.batcher
    });

    return basic_geo;
  }

}
