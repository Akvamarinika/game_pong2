package objects;

import h2d.Interactive;
import h2d.Bitmap;
import h2d.Object;
import hxd.Event;

// ? необязательный параметр
//Interactive Обработчик пользовательского ввода:   https://heaps.io/api/h2d/Interactive.html
class MyButton extends Bitmap{
    var interactive: Interactive;       
    var event: Event;

    public function new(?parent: Object, tile, onClick: (event: Event) -> Void) {
        super(tile, parent); //плитка размером с картинку

        tile.dx = -tile.width / 2;
        tile.dy = -tile.height / 2;

        interactive = new Interactive(tile.width, tile.height, this);
        interactive.setPosition(-tile.width / 2, -tile.height / 2);
        interactive.onRelease = onClick;

        scale(0.5);
    }


    public function update(dt: Float) {
        interactive.cursor = Button;

        interactive.onOver = function(e : hxd.Event) {
            this.tile = hxd.Res.imgbtn2.toTile();
            tile.dx = -tile.width / 2;
            tile.dy = -tile.height / 2;
          };

          interactive.onOut = function(e : hxd.Event) {
            this.tile = hxd.Res.imgbtn1.toTile();
            tile.dx = -tile.width / 2;
            tile.dy = -tile.height / 2;
          };  
        
    }
}