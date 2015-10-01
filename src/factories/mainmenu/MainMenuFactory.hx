package factories.mainmenu;

import luxe.Vector;
import luxe.Visual;
import luxe.Color;
import luxe.Scene;
import luxe.Sprite;

import phoenix.geometry.Vertex;
import phoenix.geometry.Geometry;
import phoenix.Batcher;
import phoenix.Camera;



class MainMenuFactory {

  private var title_sprite : Sprite;
  private var menu_batcher : Batcher;
  private var menu_view : Camera;

  public function new() {

    menu_batcher = new Batcher(Luxe.renderer, 'menu_batcher');
    var menu_view = new Camera();
    menu_batcher.view = menu_view;
    menu_batcher.layer = -1;
    Luxe.renderer.add_batch(menu_batcher);

  } //init

  public function createTitleSprite () {
    title_sprite = new Sprite({
      name:'ballon',
      texture : Luxe.resources.texture('assets/images/rasters/mainmenu/title800x205.png'),
      pos : new Vector(Luxe.screen.mid.x,180),
      centered : true,
      visible: true,
      scale: new Vector(1,1),
    });

    return title_sprite;
  }

  public function createBackdrop (color:Color){
    var shape = new luxe.Visual({
      pos: new Vector(0,0),
      visible: true,
      scale: new Vector(1,1),
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
