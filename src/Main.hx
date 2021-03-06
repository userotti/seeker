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
import luxe.Text;
import luxe.structural.Pool;
import luxe.structural.Bag;
import luxe.options.GeometryOptions;

import states.*;
import FPS;

import mint.Control;
import mint.types.Types;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;
import mint.layout.margins.Margins;

class Main extends luxe.Game {

  public static var states : luxe.States;

  public static var game_state : GameState;
  public static var main_menu_state : MainMenuState;



  public static var main_font;
  //Mint vibes
  public static var disp : Text;
  public static var canvas: mint.Canvas;
  public static var rendering: LuxeMintRender;
  public static var layout: Margins;

  var canvas_debug : Text;
  var debug : Bool = false;

  override function config(config:luxe.AppConfig) {
    config.preload.textures.push({ id:'assets/images/rasters/mainmenu/title800x205.png' });

    config.preload.textures.push({ id:'assets/images/rasters/mainmenu_title-01.png' });
    config.preload.textures.push({ id:'assets/images/rasters/mainmenu_background_1280_720.png' });

    config.preload.textures.push({ id:'assets/images/rasters/blue_weapon_flame-01.png' }); //25 x 25
    config.preload.textures.push({ id:'assets/images/rasters/blue_weapon_flame_short-01.png' }); //25 x 25
    config.preload.textures.push({ id:'assets/images/rasters/blue_weapon_smoke-01.png' }); //25 x 25

    config.preload.textures.push({ id:'assets/images/rasters/blue_hit_bang-01.png' }); //25 x 25
    config.preload.textures.push({ id:'assets/images/rasters/blue_hit_bang_top-01.png' }); //25 x 25
    config.preload.textures.push({ id:'assets/images/rasters/spark-01.png' }); //25 x 25

    config.preload.textures.push({ id:'assets/images/rasters/green_grunt_shrapnal-01.png' }); //25 x 25
    config.preload.textures.push({ id:'assets/images/rasters/green_grunt_shrapnal-02.png' }); //25 x 25
    config.preload.textures.push({ id:'assets/images/rasters/green_grunt_shrapnal-03.png' }); //25 x 25


    config.preload.textures.push({ id:'assets/images/rasters/bushes-01.png' }); //25 x 25
    config.preload.textures.push({ id:'assets/images/rasters/bushes-02.png' }); //25 x 25
    config.preload.textures.push({ id:'assets/images/rasters/bushes-03.png' }); //25 x 25
    config.preload.textures.push({ id:'assets/images/rasters/square10x10.png' }); //25 x 25

    config.preload.textures.push({ id:'assets/images/rasters/game_background_blue3.png' }); //1024 x 768
    config.preload.textures.push({ id:'assets/images/rasters/metal_guy-01.png' }); //65 x 65
    config.preload.textures.push({ id:'assets/images/rasters/metal_guy_green-01.png' }); //65 x 65
    config.preload.textures.push({ id:'assets/images/rasters/metal_guy_red-01.png' }); //65 x 65

    config.preload.textures.push({ id:'assets/images/rasters/metal_nest-01.png' }); //180 x 180
    config.preload.textures.push({ id:'assets/images/rasters/metal_nest_spikes-01.png' }); //180 x 180
    config.preload.textures.push({ id:'assets/images/rasters/yellow_ore-01.png' }); //30 x 30
    config.preload.textures.push({ id:'assets/images/rasters/force_indicator-01.png' }); //30 x 7?
    config.preload.textures.push({ id:'assets/images/rasters/smoke_triangle-01.png' }); //30 x 7?

    config.preload.fonts.push({ id:'assets/fonts/basicfont/font.fnt' });
    config.render.antialiasing = 0;
    return config;
  } //config 

  override function ready() {

    Luxe.renderer.clear_color.rgb(0x121219);


    rendering = new LuxeMintRender();
    layout = new Margins();

    main_font = Luxe.resources.font('assets/fonts/basicfont/font.fnt');
    canvas = new mint.Canvas({
        name:'canvas',
        rendering: rendering,
        options: { color:new Color(1,1,1,0.0) },
        x: 0, y:0, w: Luxe.screen.w, h: Luxe.screen.h
    });

    // canvas_debug = new Text({
    //     name:'debug.text',
    //     text: 'debug:  (${Luxe.snow.os} / ${Luxe.snow.platform})',
    //     point_size: 14,
    //     pos: new Vector(950, 10),
    //     align: right,
    //     depth: 999,
    //     color: new Color()
    // });

    states = new luxe.States({ name:'states' });
    game_state = new states.GameState({ name:'gamestate' });
    states.add(game_state);

    main_menu_state = new states.MainMenuState({ name:'mainmenustate' });
    states.add(main_menu_state);

    states.set( 'mainmenustate' );
  }

  override function onmousemove(e) {
      canvas.mousemove( Convert.mouse_event(e) );


      // var s = 'debug:  (${Luxe.snow.os} / ${Luxe.snow.platform})\n';
      // s += 'canvas nodes: ' + (canvas != null ? '${canvas.nodes}' : 'none');
      // s += '\n';
      // s += 'focused: ' + (canvas.focused != null ? '${canvas.focused.name} [${canvas.focused.nodes}]' : 'none');
      // s += (canvas.focused != null ? ' / depth: '+canvas.focused.depth : '');
      // s += '\n';
      // s += 'modal: ' + (canvas.modal != null ?  canvas.modal.name : 'none');
      // s += '\n';
      // s += 'dragged: ' + (canvas.dragged != null ? canvas.dragged.name : 'none');
      // s += '\n\n';
      // canvas_debug.text = s;

  } //onmousemove


  //Mint functions
  override function onmousewheel(e) {
      canvas.mousewheel( Convert.mouse_event(e) );
  }

  override function onmouseup(e) {
      canvas.mouseup( Convert.mouse_event(e) );
  }

  override function onmousedown(e) {
      canvas.mousedown( Convert.mouse_event(e) );
  }

  override function onkeydown(e:luxe.Input.KeyEvent) {
      canvas.keydown( Convert.key_event(e) );
  }

  override function ontextinput(e:luxe.Input.TextEvent) {
      canvas.textinput( Convert.text_event(e) );
  }

  //ESCAPE QUIT
  override function onkeyup(e:luxe.Input.KeyEvent) {

    if(e.keycode == Key.up) {
      states.set( 'gamestate' );
    }

    if(e.keycode == Key.escape) {
      states.set( 'mainmenustate' );
      //Luxe.shutdown();
    }
  }


  override function update( dt:Float ) {
    canvas.update(dt);
  }

}//Main
