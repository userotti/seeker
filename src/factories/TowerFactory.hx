package factories;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;

import components.tower.TowerMovementComponent;
import components.tower.TowerFrictionComponent;
import components.tower.TowerBoostComponent;
import components.tower.TowerBreakComponent;
import components.tower.TowerCooldownComponent;

import components.tower.TowerAppearanceComponent;

class TowerFactory {

  public function new() {

  }

  public function createTower (pos:Vector, name:String) : Visual{
    var tower = new luxe.Visual({
      name: name,
      pos: new Vector(pos.x,pos.y),
      visible: true,
      scale: new Vector(20,20),
    });

    //doesn't need any components
    var cooldown_comp = new TowerCooldownComponent({
      name: 'cooldown'
    });

    //doesn't need any components
    var move_comp = new TowerMovementComponent({
      name: 'movement'
    });

    //needs movement component
    var fric_comp = new TowerFrictionComponent({
      name: 'friction'
    });

    //needs movement component
    var break_comp = new TowerBreakComponent({
      name: 'break'
    });

    //needs movement and break and cooldown cooldown_comp
    var boost_comp = new TowerBoostComponent({
      name: 'boost'
    });

    var appearance_comp = new TowerAppearanceComponent({
      name: 'appearance'
    });

    tower.add(cooldown_comp);
    tower.add(move_comp);

    tower.add(fric_comp);
    tower.add(break_comp);
    tower.add(boost_comp);
    tower.add(appearance_comp);

    cooldown_comp.setup(0.6);
    move_comp.setup(600);

    fric_comp.setup(2);
    break_comp.setup(8);

    //boostpower, max_fuel, fuel_recharge
    boost_comp.setup(500, 300000, 300);

    tower.geometry = this.makeBasicGeometry();
    tower.geometry.color = new Color().rgb(0xff4400);

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
