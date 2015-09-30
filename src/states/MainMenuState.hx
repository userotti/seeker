package states;

import luxe.Vector;
import luxe.Input;
import luxe.Color;
import luxe.Sprite;
import luxe.Visual;
import luxe.Text;

import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

import factories.mainmenu.*;

class MainMenuState extends luxe.States.State {


  private var menu_factory : MainMenuFactory;
  private var font : MainMenuFactory;


  public function new(json:Dynamic) {
    super(json);
    menu_factory = new MainMenuFactory();
  }

  override function onenter<T>(_:T) {
    menu_factory.createBackdrop(new Color().rgb(0x0d0c1b));
    menu_factory.createTitleSprite();

    var font = Luxe.resources.font('assets/fonts/basicfont/font.fnt');

    var t = new Text({
        text: 'new game',
        pos : new Vector(Luxe.screen.mid.x,400),
        point_size : 20,
        align: center,
        color: new Color().rgb(0x425376),
        font: font
    });

    var t = new Text({
        text: 'options',
        pos : new Vector(Luxe.screen.mid.x,450),
        point_size : 20,
        align: center,
        color: new Color().rgb(0x425376),
        font: font
    });

  } //onenter

  override function onmousedown( event:MouseEvent ) {

  } //onmousemove

  override function onleave<T>(_:T) {
    //Destory everything nicely,
    // fixed.destroy();
    // fixed = null;


  } //onleave

  override function update(dt:Float) {

  }

}
