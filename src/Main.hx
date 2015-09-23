/*@userotti This is exactly what I have been doing.
Use luxe.Visual, create new phoenix.geometry.Geometry to overwrite visual.geometry,
and use add phoenix.geometry.Vertex. To define whether it is a solid or outlined polygon, set geometry.primitive_type.
I've not noticed any significant issue with performance. I'm doing this because it gives me a more consistent graphic style.*/

import luxe.Input;
import luxe.Scene;
import luxe.Sprite;
import luxe.Visual;
import luxe.Color;
import luxe.Vector;
import luxe.AppConfig;
import luxe.Particles;
import luxe.Entity;
import luxe.structural.Pool;
import luxe.structural.Bag;
import luxe.options.GeometryOptions;

import phoenix.Texture;
import phoenix.Batcher;
import phoenix.geometry.Geometry;
import phoenix.Rectangle;
import phoenix.geometry.Vertex;
import phoenix.Camera;

import factories.BackgroundShapesFactory;
import factories.TowerFactory;
import factories.HudFactory;

import FPS;


class Main extends luxe.Game {

  var mouse : Vector;
  var zoomfactor : Vector;
  var player : Visual;
  var background_factory : BackgroundShapesFactory;
  var tower_factory : TowerFactory;
  var hud_factoy : HudFactory;
  var player_name : String;
  override function config(config:luxe.AppConfig) {

    return config;
  } //config 

  override function ready() {

    player_name = 'player';

    zoomfactor = new Vector(0,0);
    tower_factory = new TowerFactory();
    background_factory = new BackgroundShapesFactory();
    hud_factoy = new HudFactory();

    background_factory.createBackdrop(new Color().rgb(0x0d0c1b));
    background_factory.createBackgroundShapeMatrix(20,20,-500,-500, 200, new Color().rgb(0x223356));


    this.player = tower_factory.createTower(new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y), player_name);

    var cooldown_stat_component = hud_factoy.createCooldownStatBar(new Vector(Luxe.screen.w-10-20, Luxe.screen.h-20), new Color().rgb(0x885632));
    cooldown_stat_component.get('cooldown_statbar_component').setTower(player_name);

    var fuel_stat_component = hud_factoy.createFuelStatBar(new Vector(Luxe.screen.w-10-20-20, Luxe.screen.h-20), new Color().rgb(0x673677));
    fuel_stat_component.get('fuel_statbar_component').setTower(player_name);

    var move_stat_component = hud_factoy.createMovementStatBar(new Vector(Luxe.screen.w-10-20-80, Luxe.screen.h-20), new Color().rgb(0x556677));
    move_stat_component.get('movement_statbar_component').setTower(player_name);

    var break_stat_component = hud_factoy.createBreakStatBar(new Vector(Luxe.screen.w-10-20-80-90, Luxe.screen.h-20), new Color().rgb(0x44aa55), new Color().rgb(0x882233));
    break_stat_component.get('break_statbar_component').setTower(player_name);


  }

  override function onmousedown( event:MouseEvent ) {
    this.player.get('boost').boostOn(Luxe.camera.screen_point_to_world(new Vector(event.x,event.y)),40);
  } //onmousemove

  //ESCAPE QUIT
  override function onkeyup( e:KeyEvent ) {
    if(e.keycode == Key.escape) {
      Luxe.shutdown();
    }
  }


  override function update( delta:Float ) {
    Luxe.camera.center.x = this.player.pos.x;
    Luxe.camera.center.y = this.player.pos.y;
    zoomfactor.x = this.player.get('movement').velocity.x;
    zoomfactor.y = this.player.get('movement').velocity.y;

    Luxe.camera.zoom = 1 - (zoomfactor.lengthsq * 0.00000025);
  }

}//Main
