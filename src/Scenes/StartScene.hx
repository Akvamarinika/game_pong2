package scenes;

import hxd.Event;
import hxd.Window;
import h2d.Tile;
import h2d.Bitmap;
import h2d.Object;
import hxd.res.Sound;
import objects.*;

class StartScene extends MyScene{
    var startButton: MyButton;
    final SCALE_VALUE = 0.9;
    public var textBitmap: Bitmap;
    public var imageBitmap: Bitmap;
    var sound: Sound;

    override public function new(main: Main, tile :Tile) {
        super(main, tile);

        sound == null ? sound = hxd.Res.mainpong : sound.stop();

        if (sound != null) {
            sound.play(true);
       }

        var tileMainImg: Tile = hxd.Res.imgracquet.toTile();
        imageBitmap = new Bitmap(tileMainImg, myScene); 

		imageBitmap.tile.dx = -tileMainImg.width / 2;
		imageBitmap.tile.dy = -tileMainImg.height / 2;
        this.imageBitmap.scale(0.15);
        imageBitmap.setPosition(Window.getInstance().width / 2, Window.getInstance().height / 2 - 200);
        var tileTitle: Tile = hxd.Res.imgtitle.toTile();
        this.setImage(tileTitle, myScene);

        var title = new h2d.Text(hxd.res.DefaultFont.get(), myScene); // font:, parent: 
        //var title = new h2d.Text(hxd.Res.AtariClassic.toFont(), scene);
        title.text = "Game up to 9 wins...";
        title.setPosition(Window.getInstance().width / 2, 300);
        title.scale(2);
        title.textAlign = Center;

        //Кнопка startButton:
            startButton = new MyButton(myScene, hxd.Res.imgbtn1.toTile(), 
            function(event: Event) {
            this.setScene(new GameScene(main, hxd.Res.background.toTile()));
            sound.stop();
            hxd.Res.btnpressed.play();
        });

        startButton.setPosition(Window.getInstance().width / 2, Window.getInstance().height - 100);

    }

    override function update(dt: Float) {
        startButton.update(dt);
    }

    private function setImage(tile: Tile, ?parent: Object) {
		textBitmap = new Bitmap(tile, parent);
		textBitmap.tile.dx = -tile.width / 2;
		textBitmap.tile.dy = -tile.height / 2;

       this.textBitmap.scale(SCALE_VALUE);
       textBitmap.setPosition(Window.getInstance().width / 2, Window.getInstance().height / 2);
    }

}