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

import states.*;
import FPS;


class Main extends luxe.Game {

  private var states : luxe.States;

  override function config(config:luxe.AppConfig) {
    config.preload.textures.push({ id:'assets/images/rasters/mainmenu/title800x205.png' });
    config.preload.fonts.push({ id:'assets/fonts/basicfont/font.fnt' });
    config.render.antialiasing = 0;
    return config;
  } //config 

  override function ready() {
    states = new luxe.States({ name:'states' });
    states.add( new states.GameState({ name:'gamestate' }) );
    states.add( new states.MainMenuState({ name:'mainmenustate' }) );

    states.set( 'mainmenustate' );
  }

  //ESCAPE QUIT
  override function onkeyup( e:KeyEvent ) {
    if(e.keycode == Key.escape) {
      Luxe.shutdown();
    }
  }


  override function update( dt:Float ) {

  }

}//Main
