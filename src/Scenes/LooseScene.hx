package scenes;

import hxd.Window;
import h2d.Tile;
import h2d.Object;
import h2d.Bitmap;

class LooseScene extends MyScene {
    public var textBitmap: Bitmap;
    public final SCALE_VALUE = 0.9;
    var timer: Float = 3;   //показывать сцену игроку X времени

    override public function new(main: Main, tile :Tile) {
        super(main, tile);

       var tile: Tile = hxd.Res.imgloose.toTile();
       this.setImage(tile, myScene);
       this.textBitmap.scale(SCALE_VALUE);
       textBitmap.setPosition(Window.getInstance().width / 2, Window.getInstance().height / 2);
       hxd.Res.gameover.play(); 
    }

    public override function update(dt: Float) {
       timer -= dt;

       if (timer <= 0) {
           this.setScene(new StartScene(main, hxd.Res.background.toTile()));
       }
    }

    private function setImage(tile: Tile, ?parent: Object) {
		textBitmap = new Bitmap(tile, parent);
		textBitmap.tile.dx = -tile.width / 2;
		textBitmap.tile.dy = -tile.height / 2;
    }
}