package factories.mainmenu;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Sprite;
import luxe.Text;



import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import phoenix.Batcher;
import phoenix.Camera;



class MainMenuFactory {

  private var title_sprite : Sprite;
  private var menu_batcher : Batcher;
  private var menu_view : Camera;
  private var scene : Scene;


  public function new(_scene:Scene) {

    scene = _scene;
    menu_batcher = new Batcher(Luxe.renderer, 'menu_batcher');
    var menu_view = new Camera();
    menu_batcher.view = menu_view;
    menu_batcher.layer = -1;
    Luxe.renderer.add_batch(menu_batcher);

  } //init

  public function createTitleSprite () {
    title_sprite = new Sprite({
      name:'title',
      texture : Luxe.resources.texture('assets/images/rasters/mainmenu/title800x205.png'),
      pos : new Vector(Luxe.screen.mid.x,180),
      centered : true,
      visible: true,
      scale: new Vector(1,1),
      scene: scene,
      batcher: menu_batcher
    });

    return title_sprite;
  }

  public function createButton (label:String, size:Float, x:Float, y:Float, w:Float, h:Float){

    var new_game_sprite = new Text({
      text: label,
      name : label,
      pos : new Vector(x, y),
      size : new Vector(w, h),
      point_size : size,
      align: center,
      color: new Color().rgb(0x425376),
      font: Main.main_font,
      scene: scene,
      batcher: menu_batcher
    });

    var new_game_button = new mint.Button({
      parent: Main.canvas,
      text: '',
      name: 'niks',
      x:new_game_sprite.pos.x-(w/2), y:new_game_sprite.pos.y, w:new_game_sprite.size.x, h:new_game_sprite.size.y,
      visible: true,
      options: {
        color: new Color().set(0,0,0,0),
        color_hover: new Color().set(0,0,0,0),
        color_down: new Color().set(0,0,0,0),
      },
      onclick: function(e,c){

      }
    });


    new_game_button.onmouseenter.listen(function(e,c){
      new_game_sprite.color = new Color().rgb(0x627396);
    });

    new_game_button.onmouseleave.listen(function(e,c){
      new_game_sprite.color = new Color().rgb(0x425376);
    });


    return new_game_button;
  }

  public function createBackdrop (color:Color){
    var shape = new luxe.Visual({
      pos: new Vector(0,0),
      visible: true,
      scale: new Vector(1,1),
      scene: scene
    });

    var basic_geo = new phoenix.geometry.Geometry({
      id: 'basic_geo',
      primitive_type: 4,
      visible: true,
      batcher: menu_batcher
    });

    basic_geo.add(new Vertex(new Vector(0,0,0)));
    basic_geo.add(new Vertex(new Vector(Luxe.screen.w,0,0)));
    basic_geo.add(new Vertex(new Vector(Luxe.screen.w,Luxe.screen.h,0)));

    basic_geo.add(new Vertex(new Vector(0,Luxe.screen.h,0)));
    basic_geo.add(new Vertex(new Vector(0,0,0)));
    basic_geo.add(new Vertex(new Vector(Luxe.screen.w,Luxe.screen.h,0)));

    shape.geometry = basic_geo;
    shape.geometry.color = color;

    return shape;

  }
}
