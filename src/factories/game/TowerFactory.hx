package factories.game;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Entity;
import luxe.Sprite;

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
import components.utility.ForceIndicatorManager;

import components.tower.AppearanceComponent;

//This class creates new Sprites and Entities and their components and adds them the scene they got from the state they're a member of.
class TowerFactory {

  private var scene : Scene;
  private var force_manager : ForceManagerComponent;

  public function new(_scene:Scene) {
    scene = _scene;
    force_manager = new ForceManagerComponent({name: 'force_manager'}, scene);
  }

  public function createMetalNest (pos:Vector, name:String) : Visual{

    var nest = new luxe.Sprite({
      name: name,
      depth: 10,
      pos: new Vector(pos.x,pos.y),
      visible: true,
      scene: scene,
      centered: true,
      texture : Luxe.resources.texture("assets/images/rasters/metal_nest-01.png"),
      batcher: Luxe.renderer.batcher
    });

    var spikes = new Sprite({
      name: name+"_spikes",
      depth: 11,
      pos: new Vector(pos.x,pos.y),
      centered: true,
      texture : Luxe.resources.texture("assets/images/rasters/metal_nest_spikes-01.png"),
      scene: scene,
      batcher: Luxe.renderer.batcher
    });

    nest.add(new ForceFieldComponent({ name: 'forcefield' }));
    nest.get('forcefield').setup(200, -150);//radius, constant_force

    return nest;

  }


  public function createTower (pos:Vector, name:String) : Visual{
    var tower = new luxe.Sprite({
      name: name,
      pos: new Vector(pos.x,pos.y),
      visible: true,
      scene: scene,
      batcher: Luxe.renderer.batcher
    });

    // tower.transform.origin.x = Luxe.resources.texture("assets/images/rasters/metal_guy_green-01.png").width/2;
    // tower.transform.origin.y = Luxe.resources.texture("assets/images/rasters/metal_guy_green-01.png").height/2;

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

    //doesnt need a forcemanager
    tower.add(new ForceFieldComponent({ name: 'forcefield' }));



    tower.depth = 9;

    var wa = Luxe.resources.texture("assets/images/rasters/metal_guy-01.png").width_actual;
    var w = Luxe.resources.texture("assets/images/rasters/metal_guy-01.png").width;

    tower.size = new Vector(wa,wa);
    tower.origin = new Vector(w/2,w/2);
    tower.texture = Luxe.resources.texture("assets/images/rasters/metal_guy-01.png");

    tower.get('cooldown').setup(4.8);
    tower.get('friction').setup(50);
    tower.get('break').setup(500);
    tower.get('boost').setup(560, 270, 40000, 1500); //boostpower, top_speed, max_fuel, fuel_recharge
    tower.get('forcefield').setup(150, 250);//radius, constant_force


    var force_indicator = new Sprite({
      name: "_force_indicator",
      depth: 12,
      pos: new Vector(32.5,32.5), //the parent (w/2, w/2)
      origin: new Vector(50,15), // (distance from the center, indicator w/2)
      visible: true,
      texture : Luxe.resources.texture("assets/images/rasters/force_indicator-01.png"),
      parent: tower,
      scene: scene,
      batcher: Luxe.renderer.batcher
    });
    //needs a force body
    force_indicator.add(new ForceIndicatorManager({name: 'forceindicator'}));


    return tower;
  }


  public function createYellowOre (pos:Vector, name:String) : Visual{
    var ore = new luxe.Sprite({
      name: name,
      pos: new Vector(pos.x,pos.y),
      visible: true,
      depth: 7,
      rotation_z: Math.random()*360,
      scene: scene,
      texture : Luxe.resources.texture("assets/images/rasters/yellow_ore-01.png"),
      batcher: Luxe.renderer.batcher
    });

    ore.add(new MovementComponent({ name: 'movement' }));
    //needs movement component
    ore.add(new AccelerationComponent({ name: 'acceleration' }));
    //needs movement component and Acceleration Componenets
    ore.add(new FrictionComponent({ name: 'friction' }));
    ore.add(force_manager);
    //needs a force manager
    ore.add(new ForceBodyComponent({ name: 'forcebody' }));

    //chird of the ore
    var force_indicator = new Sprite({
      name: "_force_indicator",
      depth: 12,
      pos: new Vector(15,15),
      origin: new Vector(25+15,0+15),
      visible: true,
      texture : Luxe.resources.texture("assets/images/rasters/force_indicator-01.png"),
      parent: ore,
      scene: scene,
      batcher: Luxe.renderer.batcher
    });
    //needs a force body
    force_indicator.add(new ForceIndicatorManager({name: 'forceindicator'}));

    ore.get('friction').setup(100);

    return ore;

  }


}
