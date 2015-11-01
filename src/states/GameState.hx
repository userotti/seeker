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
import components.effects.*;

import helpers.game.*;
import sprites.game.*;


class GameState extends luxe.States.State {

  var mouse : Vector;
  var zoomfactor : Vector;
  var player : CollidableSprite;

  private var level_name : String;

  //builders
  public var level_builder : LevelBuilder;
  private var collison_scene_manager : CollisionSceneManager;
  private var effect_scene_manager : EffectsSceneManager;
  private var background_scene : Scene;
  private var hud_scene : Scene;
  private var background_factory : BackgroundFactory;
  private var hud_factory : HudFactory;
  private var event_ids : Array<String>;
  private var paused : Bool;

  //This get created when the Main.hx is ready, so these don't ek destroyed on state changes.
  public function new(json:Dynamic) {
    super(json);

    level_name = '';
    effect_scene_manager = new EffectsSceneManager();
    collison_scene_manager = new CollisionSceneManager();
    background_scene = new Scene('background_scene');
    hud_scene = new Scene('hud_scene');
    background_factory = new BackgroundFactory(background_scene);
    hud_factory = new HudFactory(hud_scene);
    event_ids = new Array();

  }

  //need to call this before you go to the new level.
  public function setLevel(_level_name:String){
    level_name = _level_name;
  }

  public function toggelPause(){
    if (paused == false){
      effect_scene_manager.deactivateAll();
      collison_scene_manager.deactivateAll();
      paused = true;
      trace('pause');
    }else{
      effect_scene_manager.activateAllVisible();
      collison_scene_manager.activateAllVisible();
      paused = false;
      trace('unpause');
    }

  }

  //When you land on this state. This function gets called, (everytime a new game starts).
  override function onenter<T>(_:T) {

    paused = false;
    //Build the level
    setupEvents();
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

    cancelEvents();
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
    Luxe.camera.zoom = 1;

  }


  override function onkeyup(e:luxe.Input.KeyEvent) {

    if(e.keycode == Key.key_p) {

      toggelPause();
    }

  }



  //EVENTS=============================================================
  public function setupEvents(){

    event_ids.push(Luxe.events.listen('kill_collidable', function(e){
        collison_scene_manager.kill(e.collidable);
    }));

    event_ids.push(Luxe.events.listen('kill_effect', function(e){
        effect_scene_manager.kill(e.effect);
    }));

    event_ids.push(Luxe.events.listen('create_tower_shrapnal', function(e){
        LevelBuilder.makeTowerDeathShrapnal(e.collidable, collison_scene_manager);
    }));

    event_ids.push(Luxe.events.listen('attach_force_indicator', function(e){
        var effect = effect_scene_manager.getIndicator();
        EffectBuilder.makeIndicator(effect, e.force_body.owner, e.direction_vector, 40,'force_indicator-01.png', 12);
        e.force_body.indicator = effect.get(DirectionIndicatorComponent.TAG);
    }));

    event_ids.push(Luxe.events.listen('tower_shoot', function(e){
        EffectBuilder.makeWeaponBlast(e.target, e.attacker, effect_scene_manager);
    }));



    event_ids.push(Luxe.events.listen('tower_hit', function(e){
        EffectBuilder.makeHullHit(e.target, e.attacker, effect_scene_manager);
    }));

    event_ids.push(Luxe.events.listen('tower_killed', function(e){
        EffectBuilder.makeTowerDestory(e.dead_tower, effect_scene_manager);
    }));

  }

  public function cancelEvents(){
    for (event_id in event_ids){
      trace(Luxe.events.unlisten(event_id) + event_id);
    }
  }


  //BUILDLEVEL =======================================================
  //this needs to be removed into some other class
  private function buildLevel(){

    //Collidable Builder
    collison_scene_manager.setupStaticTowerPool(10);
    collison_scene_manager.setupTowerPool(20);
    collison_scene_manager.setupPushablePool(250);
    effect_scene_manager.setupFloaterPool(100);
    effect_scene_manager.setupIndicatorPool(100);

    switch level_name{

    case 'level1':

      player = collison_scene_manager.getTower();
      LevelBuilder.makeMinorRedHexGrunt(player, new Vector(0,0));
      LevelBuilder.makeMinorGreenRectGrunt(collison_scene_manager.getTower(), new Vector(0 - 350, 0 + 0));
      background_factory.createBackdrop(new Color().rgb(0x071c16));

    case 'level2':

      player = collison_scene_manager.getTower();
      LevelBuilder.makeMinorRedHexGrunt(player, new Vector(0,0));
      LevelBuilder.makeMinorGreenRectGrunt(collison_scene_manager.getTower(), new Vector(0 - 350, 0 + 0));
      LevelBuilder.makeMinorGreenRectGrunt(collison_scene_manager.getTower(), new Vector(0 + 350, 0 + 0));
      LevelBuilder.makeMinorGreenRectGrunt(collison_scene_manager.getTower(), new Vector(0 - 350, 0 + 350));
      background_factory.createBackdrop(new Color().rgb(0x071c16));
      LevelBuilder.makeOrePatch(50, 150,150, new Vector(-650,0), collison_scene_manager);
      LevelBuilder.makeOrePatch(50, 200,200, new Vector(-350,-300), collison_scene_manager);
      LevelBuilder.makeOrePatch(50, 200,200, new Vector(-300,450), collison_scene_manager);
      LevelBuilder.makeMetalNest(collison_scene_manager.getStaticTower(), new Vector(0, 0));

    case 'level3':

      player = collison_scene_manager.getTower();
      LevelBuilder.makeMinorRedHexGrunt(player, new Vector(0,0));

    }

  }

}
