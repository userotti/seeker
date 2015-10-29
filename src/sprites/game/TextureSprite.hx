package sprites.game;

import luxe.Sprite;
import luxe.Vector;



class TextureSprite extends Sprite{

  public function new(_json:Dynamic) {
    super(_json);
  };

  public function resetTexture(_texture:String, _depth: Int){

    depth = _depth;
    var wa = Luxe.resources.texture("assets/images/rasters/"+_texture).width_actual;
    var w = Luxe.resources.texture("assets/images/rasters/"+_texture).width;

    var ha = Luxe.resources.texture("assets/images/rasters/"+_texture).height_actual;
    var h = Luxe.resources.texture("assets/images/rasters/"+_texture).height;

    size = new Vector(wa,ha);
    origin = new Vector(w/2,h/2);
    texture = Luxe.resources.texture("assets/images/rasters/"+_texture);

  }


}
