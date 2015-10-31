package components.tower;

import luxe.Component;
import luxe.Vector;
import luxe.Sprite;
import luxe.Visual;


class MetaDataComponent extends Component {

  public static var TAG = 'MetaDataComponent';

  public var tower : Sprite;
  public var type_name : String;
  public var sub_type_name : String;


  public function new(json:Dynamic){
    super(json);
  }

  override function init() {
    tower = cast entity;
  } //init

  // override function update(dt:Float) {
  //
  // } //update

  public function setup(_type_name:String, _sub_type_name:String) {
    type_name = _type_name;
    sub_type_name = _sub_type_name;
  } //init

}
