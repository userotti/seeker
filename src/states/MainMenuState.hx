package states;

import luxe.Vector;
import luxe.Input;
import luxe.Color;
import luxe.Sprite;
import luxe.Visual;
import luxe.Text;
import luxe.Entity;
import luxe.Scene;


import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

import mint.Control;
import mint.types.Types;
import mint.render.luxe.Convert;
import mint.render.luxe.Label;
import mint.layout.margins.Margins;

import factories.mainmenu.*;

class MainMenuState extends luxe.States.State {

  private var menu_factory : MainMenuFactory;
  private var font : MainMenuFactory;
  private var scene : Scene;

  var bg: luxe.Sprite;
  //some controls we want to edit outside of their scope
  var progress: mint.Progress;
  var text1: mint.TextEdit;

  //Constructor
  public function new(json:Dynamic) {
    super(json);
    scene = new Scene('mainmenuscene');
    menu_factory = new MainMenuFactory(scene);

  }

  //onenter
  override function onenter<T>(_:T) {
    trace('mainnenustate onenter');
    menu_factory.createBackdrop(new Color().rgb(0x0d0c1b));
    menu_factory.createTitleSprite();

    var mint_btn = menu_factory.createButton('New Game', 15, Luxe.screen.mid.x, 400, 150, 50);
    mint_btn.onmousedown.listen(function(e,c){
      Main.states.set('gamestate');
    });

    // var mint_btn2 = menu_factory.createButton('Options', 15, Luxe.screen.mid.x, 450, 150, 50);
    // mint_btn2.onmousedown.listen(function(e,c){
    //   trace("clicked");
    // });

  } //onenter

  override function onleave<T>(_:T) {
    trace('mainnenustate onleave');
    scene.empty();
    Main.canvas.destroy_children();

  } //onleave

  override function update(dt:Float) {

  }

}
