package states;

import luxe.Vector;
import luxe.Input;
import luxe.Color;
import luxe.Sprite;
import luxe.Visual;


import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

import factories.gamestate.*;

class GameState extends luxe.States.State {

  var mouse : Vector;
  var zoomfactor : Vector;
  var player : Visual;
  var player_name : String;

  private var background_factory : BackgroundShapesFactory;
  private var tower_factory : TowerFactory;
  private var hud_factoy : HudFactory;


  public function new(json:Dynamic) {
    super(json);
    tower_factory = new TowerFactory();
    background_factory = new BackgroundShapesFactory();
    hud_factoy = new HudFactory();
  }


  override function onenter<T>(_:T) {

    player_name = 'player';

    zoomfactor = new Vector(0,0);
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

  } //onenter

  override function onmousedown( event:MouseEvent ) {
    this.player.get('boost').boostOn(Luxe.camera.screen_point_to_world(new Vector(event.x,event.y)),40);
  } //onmousemove

  override function onleave<T>(_:T) {
    //Destory everything nicely,
    // fixed.destroy();
    // fixed = null;



  } //onleave

  override function update(dt:Float) {
    Luxe.camera.center.x = this.player.pos.x;
    Luxe.camera.center.y = this.player.pos.y;
    zoomfactor.x = this.player.get('movement').velocity.x;
    zoomfactor.y = this.player.get('movement').velocity.y;

    Luxe.camera.zoom = 1 - (zoomfactor.lengthsq * 0.00000025);
  }

}
