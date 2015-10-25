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

import components.tower.FrictionComponent;
import components.tower.BoostComponent;


import helpers.game.*;

class GameState extends luxe.States.State {

  var mouse : Vector;
  var zoomfactor : Vector;
  var player : Sprite;

  private var level_name : String;

  //builders
  public var collidable_sprite_builder : CollidableSpriteBuilder;

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

    collidable_sprite_builder = new CollidableSpriteBuilder();

    effect_scene_manager = new EffectsSceneManager();
    collison_scene_manager = new CollisionSceneManager(effect_scene_manager.effect_sprite_builder);

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

    // trace("player.pos.x: " + player.pos.x);
    // trace("player.pos.y: " + player.pos.y);
    // trace("collision tree: " + collison_scene_manager.collision_tree_manager.collision_tree);
    //


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
    }

    Luxe.camera.zoom = 1;// - (zoomfactor.lengthsq * 0.00000025);
  }

  //this needs to be removed into some other class
  private function buildLevel(){

    //Collidable Builder
    var cb = collidable_sprite_builder;

    collison_scene_manager.setupStaticTowerPool(10);
    collison_scene_manager.setupTowerPool(10);
    collison_scene_manager.setupPushablePool(250);

    switch level_name{

    case 'level1':

      player = collison_scene_manager.getTower();
      cb.setTower(player,new Vector(Luxe.screen.mid.x+350, Luxe.screen.mid.y), "metal_guy_red-01.png");
      cb.setTowerLevelAttributes(player);
      cb.setTowerStats(player, 400, 310, 140000, 1500, 200, -150);

      background_factory.createBackdrop(new Color().rgb(0x0d0c1b));

      var dude = collison_scene_manager.getTower();
      cb.setTower(dude, new Vector(Luxe.screen.mid.x - 350, Luxe.screen.mid.y-400), "metal_guy_green-01.png");
      cb.setTowerLevelAttributes(dude);
      cb.setTowerStats(dude, 100, 360, 140000, 1500, 250, 150);

      for(i in 0...4){
        var pushable = collison_scene_manager.getPushable();
        cb.setPushable(pushable, new Vector(Luxe.screen.mid.x+(Math.random()*200) + -100, Luxe.screen.mid.y+(Math.random()*100) - 200));
        pushable.get(FrictionComponent.TAG).setup(100);
        cb.setPushableAppearance(pushable,"yellow_ore-01.png");

      };

      var metal_nest = collison_scene_manager.getStaticTower();
      cb.setStaticTower(metal_nest,new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y-400), "metal_nest-01.png");
      cb.setStaticTowerStats(metal_nest,200,200);

    case 'level2':

      player = collison_scene_manager.getTower();
      cb.setTower(player,new Vector(Luxe.screen.mid.x+350, Luxe.screen.mid.y), "metal_guy-01.png");
      cb.setTowerLevelAttributes(player);
      cb.setTowerStats(player, 400, 310, 140000, 1500, 150, 350);


      var dude = collison_scene_manager.getTower();
      cb.setTower(dude,new Vector(Luxe.screen.mid.x - 250, Luxe.screen.mid.y-400), "metal_guy_green-01.png");
      cb.setTowerLevelAttributes(dude);
      cb.setTowerStats(dude, 100, 360, 140000, 1500, 250, 150);

      var dude1 = collison_scene_manager.getTower();
      cb.setTower(dude1, new Vector(Luxe.screen.mid.x + 250, Luxe.screen.mid.y-400), "metal_guy_green-01.png");
      cb.setTowerLevelAttributes(dude1);
      cb.setTowerStats(dude1, 100, 360, 140000, 1500, 250, 150);

      var dude2 = collison_scene_manager.getTower();
      cb.setTower(dude2,new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y), "metal_guy_green-01.png");
      cb.setTowerLevelAttributes(dude2);
      cb.setTowerStats(dude2, 100, 360, 140000, 1500, 250, 150);


      background_factory.createBackdrop(new Color().rgb(0x071c16));
      for(i in 0...60){
        var pushable = collison_scene_manager.getPushable();
        cb.setPushable(pushable, new Vector(Luxe.screen.mid.x+(Math.random()*200) + -100, Luxe.screen.mid.y+(Math.random()*100) - 200));
        pushable.get(FrictionComponent.TAG).setup(100);
        cb.setPushableAppearance(pushable,"yellow_ore-01.png");

      };

    case 'level3':

      player = collison_scene_manager.getTower();
      cb.setTower(player,new Vector(Luxe.screen.mid.x+350, Luxe.screen.mid.y), "metal_guy_green-01.png");
      cb.setTowerLevelAttributes(player);
      cb.setTowerStats(player, 400, 310, 140000, 1500, 200, 150);

      background_factory.createBackdrop(new Color().rgb(0x0d0c1b));


      for(i in 0...240){
        var pushable = collison_scene_manager.getPushable();
        cb.setPushable(pushable, new Vector(Luxe.screen.mid.x+(Math.random()*200) + -100, Luxe.screen.mid.y+(Math.random()*100) - 200));
        pushable.get(FrictionComponent.TAG).setup(100);
        cb.setPushableAppearance(pushable,"yellow_ore-01.png");

      };

      var metal_nest = collison_scene_manager.getStaticTower();
      cb.setStaticTower(metal_nest,new Vector(Luxe.screen.mid.x-200, Luxe.screen.mid.y-400), "metal_nest-01.png");
      cb.setStaticTowerStats(metal_nest,200,200);
    }

  }

}
