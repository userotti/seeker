package states;

import luxe.Vector;
import luxe.Input;
import luxe.Color;
import luxe.Sprite;
import luxe.Visual;
import luxe.Scene;

import phoenix.Camera;
import phoenix.Matrix;

import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

import factories.game.*;

class GameState extends luxe.States.State {

  var mouse : Vector;
  var zoomfactor : Vector;
  var player : Visual;

  var player_name : String;

  private var background_scene : Scene;
  private var collision_scene : Scene;
  private var level_scene : Scene;
  private var hud_scene : Scene;

  private var background_factory : BackgroundFactory;
  private var tower_factory : TowerFactory;
  private var level_factory : LevelFactory;
  private var hud_factory : HudFactory;
  //
  // private var ForceManagerComponent :


  //This get created when the Main.hx is ready, so these don't ek destroyed on state changes.
  public function new(json:Dynamic) {
    trace('new');
    super(json);

    background_scene = new Scene('background_scene');
    collision_scene = new Scene('collision_scene');
    level_scene = new Scene('level_scene');
    hud_scene = new Scene('hud_scene');

    //Background Batcher, different Camera, doesn't move, adds things to the background scene.
    background_factory = new BackgroundFactory(background_scene);

    //Default Batcher, main game Camera, adds things to the Collision Scene
    tower_factory = new TowerFactory(collision_scene);

    //Default Bactcher, main game Camrea, adds things to the Level Scene, level scene is basicly everthings that is not a collidable.
    level_factory = new LevelFactory(level_scene);

    //Hud Batcher, different Camera, all the hud things.
    hud_factory = new HudFactory(hud_scene);

  }

  //When you land on this state. This function gets called, (everytime a new game starts).
  override function onenter<T>(_:T) {
    trace('onenter');
    player_name = 'fokker';
    zoomfactor = new Vector(0,0);

    background_factory.createBackdrop(new Color().rgb(0x0d0c1b));
    level_factory.createBackgroundShapeMatrix(20,20,-500,-500, 200, new Color().rgb(0x223356));

    player = tower_factory.createTower(new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y), player_name);

    var dude : Visual;

    dude = tower_factory.createStilTower(new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y-400), "dude");

    var rock1 : Visual;
    var rock2 : Visual;
    var rock3 : Visual;

    for(i in 0...20){
      tower_factory.createRock(new Vector(Luxe.screen.mid.x+(Math.random()*200) + 100, Luxe.screen.mid.y+(Math.random()*400) + 0), 'rock1'+i);
    }



    hud_factory.createCooldownStatBar(new Vector(Luxe.screen.w-10-20, Luxe.screen.h-20), new Color().rgb(0x885632)).setTower(player);
    hud_factory.createFuelStatBar(new Vector(Luxe.screen.w-10-20-20, Luxe.screen.h-20), new Color().rgb(0x673677)).setTower(player);
    hud_factory.createMovementStatBar(new Vector(Luxe.screen.w-10-20-80, Luxe.screen.h-20), new Color().rgb(0x556677)).setTower(player);
    hud_factory.createBreakStatBar(new Vector(Luxe.screen.w-10-20-80-90, Luxe.screen.h-20), new Color().rgb(0x44aa55), new Color().rgb(0x882233)).setTower(player);

  } //onenter

  //Click on the gate state
  override function onmousedown( event:MouseEvent ) {
    trace('onmousedown');
    player.get('boost').boostOn(Luxe.camera.screen_point_to_world(new Vector(event.x,event.y)),40);

  } //onmousemove


  //This gets called when the state changes. Menu -> Game
  override function onleave<T>(_:T) {
    trace('gamestate onleave');

    background_scene.empty();
    collision_scene.empty();
    hud_scene.empty();
    level_scene.empty();

  } //onleave

  //This gets called every tick
  override function update(dt:Float) {
    Luxe.camera.center.x = player.pos.x;
    Luxe.camera.center.y = player.pos.y;

    Luxe.camera.zoom = 1;// - (zoomfactor.lengthsq * 0.00000025);
  }

}
