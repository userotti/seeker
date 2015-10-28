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

import components.tower.*;

import helpers.game.*;
import sprites.game.*;


class GameState extends luxe.States.State {

  var mouse : Vector;
  var zoomfactor : Vector;
  var player : TextureSprite;

  private var level_name : String;

  //builders
  public var level_builder : LevelBuilder;

  private var collison_scene_manager : CollisionSceneManager;
  private var effect_scene_manager : EffectsSceneManager;

  private var background_scene : Scene;
  private var hud_scene : Scene;
  private var background_factory : BackgroundFactory;
  private var hud_factory : HudFactory;


  //This get created when the Main.hx is ready, so these don't ek destroyed on state changes.
  public function new(json:Dynamic) {
    trace('new');
    super(json);

    level_name = '';

    effect_scene_manager = new EffectsSceneManager();
    collison_scene_manager = new CollisionSceneManager(effect_scene_manager);

    background_scene = new Scene('background_scene');
    hud_scene = new Scene('hud_scene');
    background_factory = new BackgroundFactory(background_scene);
    hud_factory = new HudFactory(hud_scene);

  }

  //need to call this before you go to the new level.
  public function setLevel(_level_name:String){
    level_name = _level_name;
  }

  //When you land on this state. This function gets called, (everytime a new game starts).
  override function onenter<T>(_:T) {

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
      player.get(BoostComponent.TAG).boostOn(Luxe.camera.screen_point_to_world(new Vector(event.x,event.y)),40);
    }

  } //onmousemove

  //This gets called when the state changes. Menu -> Game
  override function onleave<T>(_:T) {

    effect_scene_manager.destroyContents();
    collison_scene_manager.destroyContents();

    background_scene.empty();
    hud_scene.empty();

  } //onleave

  //This gets called every tick
  override function update(dt:Float) {

    collison_scene_manager.updateCollisionTree(dt);
    if (player != null){
      Luxe.camera.center.x = player.pos.x;
      Luxe.camera.center.y = player.pos.y;
    }else{
      Luxe.camera.center.x = 0;
      Luxe.camera.center.y = 0;
    }

    Luxe.camera.zoom = 1;// - (zoomfactor.lengthsq * 0.00000025);
  }

  //this needs to be removed into some other class
  private function buildLevel(){

    //Collidable Builder
    collison_scene_manager.setupStaticTowerPool(10);
    collison_scene_manager.setupTowerPool(20);
    collison_scene_manager.setupPushablePool(250);
    effect_scene_manager.setupFloaterPool(100);

    switch level_name{

    case 'level1':
      player = collison_scene_manager.getTower();
      LevelBuilder.makeMinorBlueTriGrunt(player, new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y + 0));

      for(i in 1...10){
        LevelBuilder.makeMinorRedHexGrunt(collison_scene_manager.getTower(), new Vector(Math.random(), Math.random()));
      }

      background_factory.createBackdrop(new Color().rgb(0x071c16));
      
    case 'level2':

      player = collison_scene_manager.getTower();
      LevelBuilder.makeMinorBlueTriGrunt(player, new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y + 0));

      LevelBuilder.makeMinorGreenRectGrunt(collison_scene_manager.getTower(), new Vector(Luxe.screen.mid.x - 350, Luxe.screen.mid.y + 0));

      background_factory.createBackdrop(new Color().rgb(0x071c16));

      LevelBuilder.makeOrePatch(20, 150,150, new Vector(0,0), collison_scene_manager);
      LevelBuilder.makeOrePatch(20, 200,200, new Vector(550,0), collison_scene_manager);
      LevelBuilder.makeOrePatch(20, 200,200, new Vector(-300,550), collison_scene_manager);

      LevelBuilder.makeMetalNest(collison_scene_manager.getStaticTower(), new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y));

    case 'level3':


    }

  }

}
