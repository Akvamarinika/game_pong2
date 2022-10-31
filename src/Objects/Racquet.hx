package objects;

import h2d.Tile;
import h2d.Object;
import h2d.Bitmap;
import hxd.Key;
import h2d.col.Bounds;
import enums.*;


class Racquet extends Object{
    public final SCALE_VALUE = 0.3;
    var playerType: PlayerType; //human or cpu
    var positionType: PositionType; //left or right side
    public var bitmap: Bitmap;
    var velocity_Y: Float = 6;
    var direction_Y: Int = 0;
    var location = new Vector2d();
    var ball : Ball;

    public function new(playerType :PlayerType, positionType :PositionType, ?parent :Object) {
		super(parent);
		this.playerType = playerType;
		this.positionType = positionType;

        //изображение ракетки
        var tile: Tile = positionType == PositionType.LEFT_RACQUET ? hxd.Res.player.toTile() : hxd.Res.cpu.toTile();
		this.setImage(tile, parent);
        this.bitmap.scale(SCALE_VALUE);
	}

	public function update(dt: Float) {
        if (playerType == PlayerType.CPU && ball != null) {
            direction_Y = this.CPUMovementLogic();
        } else {
            direction_Y = this.playerMovement();
        }

        y = y + (direction_Y * velocity_Y);
        bitmap.y = y;
        trace('racquet  y = $y');

        this.checkGameSceneCollisions();
	}


    private function setImage(tile: Tile, ?parent: Object) {
		bitmap = new Bitmap(tile, parent);
		bitmap.tile.dx = -tile.width / 2;
		bitmap.tile.dy = -tile.height / 2;
    }


    private function CPUMovementLogic() {
        var deltaX = Math.abs(ball.x - this.x);
        var dir = 0;

        if ((ball.y < this.y + this.bitmap.height / 2 - 15 && ball.y > this.y - this.bitmap.height / 2 + 15) || deltaX > (parent.getScene().width / 2 - 120)) {
            dir = 0;
        } else if (ball.y > this.y) {
            dir = 1;
        } else if (ball.y < this.y) {
            dir = -1;
        }

        return dir;
    }

    private function playerMovement() {
        var dir = 0;

        switch positionType {
            case PositionType.LEFT_RACQUET:
                if (Key.isDown(Key.UP) || Key.isDown(Key.W)) {
                    dir = -1;
                }

                if (Key.isDown(Key.DOWN) || Key.isDown(Key.S)) {
                    dir = 1;
                }

            case _:    
        }

        return dir;
    }

    //задать позицию Плитки
    public function setNewPosition(x: Float, y: Float) {
		this.bitmap.setPosition(x, y);
        this.x = x;
        this.y = y;
    }


    //проверка выхода за границы экрана
    private function checkGameSceneCollisions() {
        var height = bitmap.tile.height / 2 * bitmap.scaleY;
		//trace('height(tile = $height)' );
        //trace(parent.getScene().height);

        if (y - height < 0) {
			y = 0 + height ;
		}

		if (y + height > parent.getScene().height) {
			y = parent.getScene().height - height;
		}
	}

       public function getBoundsBitmap() {
        return bitmap.getBounds();
       }

       public function setBall(ball :Ball) {
        this.ball = ball;
      }
}