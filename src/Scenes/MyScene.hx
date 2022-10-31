//Общий класс Сцена (для наследования)
package scenes;

import h2d.Tile;

class MyScene {
    public var myScene = new h2d.Scene();
    public var main: Main;
    var width: Int;
    var height: Int;

    public function new(main: Main, tile:Tile) {
        this.main = main;


       var bg  = new h2d.Bitmap(tile, myScene); //hxd.Res.background.toTile()
       width = Std.int(bg.getBounds().width); //x:
       height = Std.int(bg.getBounds().height); //x:
       myScene.scaleMode = ScaleMode.Stretch(width, height); //width:, height:  
    }

    public function update(dt: Float) {}

    public function setScene(newScene: MyScene) {
        main.currentScene = newScene;
        main.setScene(newScene.myScene);
    }

    public function setBackground(tile:Tile) {
        var bg  = new h2d.Bitmap(tile, myScene);
        width = Std.int(bg.getBounds().width); //x:
        height = Std.int(bg.getBounds().height); //x:
        myScene.scaleMode = ScaleMode.Stretch(width, height); //width:, height: 
    }
}