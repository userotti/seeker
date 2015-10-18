package states;

import luxe.Vector;
import luxe.Input;
import luxe.Color;
import luxe.Sprite;
import luxe.Visual;
import luxe.Scene;
import luxe.Sprite;

import phoenix.Camera;
import phoenix.Matrix;

import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

import factories.game.*;

class GameState extends luxe.States.State {

  var mouse : Vector;
  var zoomfactor : Vector;
  var player : Sprite;

  var player_name : String;

  private var background_scene : Scene;
  private var collision_scene : Scene;
  private var level_scene : Scene;
  private var hud_scene : Scene;

  private var level_name : String;

  private var background_factory : BackgroundFactory;
  private var tower_factory : TowerFactory;
  private var level_factory : LevelFactory;
  private var hud_factory : HudFactory;

  //This get created when the Main.hx is ready, so these don't ek destroyed on state changes.
  public function new(json:Dynamic) {
    trace('new');
    super(json);

    level_name = 'level1';
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

  //need to call this before you go to the new level.
  public function setLevel(_level_name:String){
    level_name = _level_name;
  }

  //When you land on this state. This function gets called, (everytime a new game starts).
  override function onenter<T>(_:T) {

    tower_factory.setupPools(10, 100); //tower,

    //Build the level
    buildLevel();

    hud_factory.createCooldownStatBar(new Vector(Luxe.screen.w-10-20, Luxe.screen.h-20), new Color().rgb(0x885632)).setTower(player);
    hud_factory.createFuelStatBar(new Vector(Luxe.screen.w-10-20-20, Luxe.screen.h-20), new Color().rgb(0x673677)).setTower(player);
    hud_factory.createMovementStatBar(new Vector(Luxe.screen.w-10-20-80, Luxe.screen.h-20), new Color().rgb(0x556677)).setTower(player);
    hud_factory.createBreakStatBar(new Vector(Luxe.screen.w-10-20-80-90, Luxe.screen.h-20), new Color().rgb(0x44aa55), new Color().rgb(0x882233)).setTower(player);

  } //onenter

  //Click on the gate state
  override function onmousedown( event:MouseEvent ) {
    trace('onmousedown');
    if (player != null){
      player.get('boost').boostOn(Luxe.camera.screen_point_to_world(new Vector(event.x,event.y)),40);
    }

  } //onmousemove

  //This gets called when the state changes. Menu -> Game
  override function onleave<T>(_:T) {

    background_scene.empty();
    collision_scene.empty();
    hud_scene.empty();
    level_scene.empty();
    tower_factory.destroyPools();

  } //onleave

  //This gets called every tick
  override function update(dt:Float) {
    if (player != null){
      Luxe.camera.center.x = player.pos.x;
      Luxe.camera.center.y = player.pos.y;
    }

    Luxe.camera.zoom = 1;// - (zoomfactor.lengthsq * 0.00000025);
  }

  //this needs to be removed into some other class
  private function buildLevel(){
    switch level_name{
    case 'level1':

      player = tower_factory.createTower(new Vector(Luxe.screen.mid.x+350, Luxe.screen.mid.y), "metal_guy_red-01.png");
      tower_factory.setTowerLevelAttributes(player);
      tower_factory.setTowerStats(player, 400, 310, 140000, 1500, 200, -150);

      background_factory.createBackdrop(new Color().rgb(0x0d0c1b));

      var dude = tower_factory.createTower(new Vector(Luxe.screen.mid.x - 350, Luxe.screen.mid.y-400), "metal_guy_green-01.png");
      tower_factory.setTowerLevelAttributes(dude);
      tower_factory.setTowerStats(dude, 100, 360, 140000, 1500, 250, 150);

      for(i in 0...40){
        var pushable = tower_factory.createPushable(new Vector(Luxe.screen.mid.x+(Math.random()*200) + -100, Luxe.screen.mid.y+(Math.random()*100) - 200));
        pushable.get('friction').setup(100);
        tower_factory.setPushableAppearance(pushable,"yellow_ore-01.png");

      };
      tower_factory.createMetalNest(new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y-400), "dude");

    case 'level2':

      player = tower_factory.createTower(new Vector(Luxe.screen.mid.x+350, Luxe.screen.mid.y), "metal_guy-01.png");
      tower_factory.setTowerLevelAttributes(player);
      tower_factory.setTowerStats(player, 400, 310, 140000, 1500, 150, 350);


      var dude = tower_factory.createTower(new Vector(Luxe.screen.mid.x - 250, Luxe.screen.mid.y-400), "metal_guy_green-01.png");
      tower_factory.setTowerLevelAttributes(dude);
      tower_factory.setTowerStats(dude, 100, 360, 140000, 1500, 250, 150);

      var dude1 = tower_factory.createTower(new Vector(Luxe.screen.mid.x + 250, Luxe.screen.mid.y-400), "metal_guy_green-01.png");
      tower_factory.setTowerLevelAttributes(dude1);
      tower_factory.setTowerStats(dude1, 100, 360, 140000, 1500, 250, 150);

      var dude2 = tower_factory.createTower(new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y), "metal_guy_green-01.png");
      tower_factory.setTowerLevelAttributes(dude2);
      tower_factory.setTowerStats(dude2, 100, 360, 140000, 1500, 250, 150);


      background_factory.createBackdrop(new Color().rgb(0x071c16));
      for(i in 0...40){
        var pushable = tower_factory.createPushable(new Vector(Luxe.screen.mid.x+(Math.random()*200) + -100, Luxe.screen.mid.y+(Math.random()*100) - 200));
        pushable.get('friction').setup(100);
        tower_factory.setPushableAppearance(pushable,"yellow_ore-01.png");

      };
    }
  }

}
