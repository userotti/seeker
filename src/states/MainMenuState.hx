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
  var canvas: mint.Canvas;
  var text1: mint.TextEdit;



  //Constructor
  public function new(json:Dynamic) {
    super(json);
    menu_factory = new MainMenuFactory();
    scene = new Scene('mainmenuscene');

  }

  //onenter
  override function onenter<T>(_:T) {

    canvas = Main.canvas;
    scene.add(menu_factory.createBackdrop(new Color().rgb(0x0d0c1b)));
    scene.add(menu_factory.createTitleSprite());

    var font = Luxe.resources.font('assets/fonts/basicfont/font.fnt');


    var width = 150;
    new mint.Label({
        parent: canvas,
        name: 'label_new_game',
        x:Luxe.screen.mid.x-(width/2), y:400, w:width, h:32,
        text: 'New Game',
        align: TextAlign.center,
        options: {
          color:new Color().rgb(0x425376),
          color_hover: new Color().rgb(0xffffff)
        },
        text_size: 35,
        onclick: function(e,c) {
          Main.states.set( 'gamestate' );
        }
    });

    new mint.Label({
        parent: canvas,
        name: 'label_options',
        x:Luxe.screen.mid.x-(width/2), y:440, w:width, h:32,
        text: 'Options',
        align: TextAlign.center,
        options: {
          color:new Color().rgb(0x425376),
          color_hover: new Color().rgb(0xffffff)
        },

        text_size: 35,
        onclick: function(e,c) {

        }
    });

    // var t = new Text({
    //     text: 'options',
    //     pos : new Vector(Luxe.screen.mid.x,450),
    //     point_size : 20,
    //     align: center,
    //     color: new Color().rgb(0x425376),
    //     font: font
    // });

    create_basics();


  } //onenter


  //Mint vibes
  function create_basics() {


      //
      // inline function make_slider(_n,_x,_y,_width,_height,_color,_min,_max,_initial,_step:Null<Float>,_vert) {
      //
      //     var _s = new mint.Slider({
      //         parent: canvas,
      //         name: _n,
      //         x:_x,
      //         y:_y,
      //         w:_width,
      //         h:_height,
      //         options: { color_bar:new Color().rgb(_color) },
      //         min: _min,
      //         max: _max,
      //         step: _step,
      //         vertical: _vert,
      //         value: _initial
      //     });
      //
      //     var _l = new mint.Label({
      //         parent:_s,
      //         text_size:12,
      //         x:0,
      //         y:0,
      //         w:_s.w,
      //         h:_s.h,
      //         align: center,
      //         name : _s.name+'.label', text: '${_s.value}'
      //     });
      //
      //     _s.onchange.listen(function(_val,_) { _l.text = '$_val'; });
      //
      // } //make_slider
      //
      // make_slider('slider1', 10, 330, 128, 24, 0x9dca63, -100, 100, 0, 1, false);
      //
      //
      //
      //
      // new mint.Button({
      //     parent: canvas,
      //     name: 'button2',
      //     x: 76, y: 52, w: 120, h: 20,
      //     text: 'O',
      //     options: { color_hover: new Color().rgb(0xf6007b) },
      //     text_size: 16,
      //     onclick: function(e,c) {trace('mint button! ${Luxe.time}' );}
      // });
      //
      //
      // new mint.Panel({
      //     parent: canvas,
      //     name: 'panel1',
      //     x:84, y:120, w:32, h: 32,
      // });



  } //create_basics

  override function onleave<T>(_:T) {
    Main.canvas.destroy_children();
    scene.empty();

  } //onleave

  override function update(dt:Float) {

  }

}
