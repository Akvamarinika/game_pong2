package scenes;

import objects.*;
import enums.*;
import hxd.Window;
import hxd.Key;
import hxd.res.Sound;
import h2d.Tile;

class GameScene extends MyScene {
    var ball: Ball;
    var player: Racquet;
    var cpu: Racquet;
    var score: Score;
    var sound: Sound;

    public override function new(main: Main, tile :Tile) {
        super(main, tile);

        sound == null ? sound = hxd.Res.keygen : sound.stop();

        if (sound != null) {
            sound.play(true);
       }
        //var title = new h2d.Text(hxd.Res.AtariClassic.toFont(), scene);     //установка шрифта из ресурсов
        this.generateLine();

        ball = new Ball(myScene); //разместить на сцене

        player = new Racquet(PlayerType.HUMAN, PositionType.LEFT_RACQUET, myScene);
        player.setNewPosition(100, Window.getInstance().height / 2);

        cpu = new Racquet(PlayerType.CPU, PositionType.RIGHT_RACQUET, myScene);
        cpu.setNewPosition(Window.getInstance().width - 100, Window.getInstance().height / 2);

        score = new Score(myScene, this, main);
        score.setPosition(Window.getInstance().width / 2, 40);
    }


    public override function update(dt: Float) {
        trace('Ball Velocity: ' + ball.velocity);

        //бросить мяч по нажатию любой кнопки:
        for (i in 0...1024) {
            if (Key.isPressed(i)) {
                player.setBall(ball);
                cpu.setBall(ball);
                ball.throwBall();
            }
        }    

        trace('Player: ');
        checkBallAndRacquetCollisions(ball, player, dt);
        trace('CPU: ');
        checkBallAndRacquetCollisions(ball, cpu, dt);

        ball.update(dt);
        player.update(dt);
        cpu.update(dt);
        
        //выход по Esc в стартовую сцену:
        if (Key.isPressed(Key.ESCAPE)) {
            setScene(new StartScene(main, hxd.Res.background.toTile()));
            
            if (sound != null) {
                sound.stop();
           }
        }
    }

    //проверить столкновение ракеток с мячом:
    private function checkBallAndRacquetCollisions(ball: Ball, racquet: Racquet, dt: Float) {
        trace('ball Bounds: ' + ball.getBoundsBitmap());
        trace('racquet Bounds: ' + racquet.getBoundsBitmap());
        trace(ball.getBoundsBitmap().intersects(racquet.getBoundsBitmap()));
        
        if (ball.getBoundsBitmap().intersects(racquet.getBoundsBitmap())) {
           // trace('*********************************************************');
            var ballPosition = new Vector2d(ball.x, ball.y);
            var racquetPosition = new Vector2d(racquet.getBoundsBitmap().x, racquet.getBoundsBitmap().y);
            var dir = ballPosition.sub(racquetPosition).norm();
            trace('DIR: ' + dir);
            ball.direction = dir;
            ball.addAccelleration(dt);

            ball.createParticles();
            hxd.Res.pong.play();
        }
        
	}

    private function generateLine(){
        var place = 0;
        while (place < Window.getInstance().height) {
            var line = new h2d.Text(hxd.res.DefaultFont.get(), myScene); // font:, parent:
            line.setPosition(Window.getInstance().width / 2, place);
            line.text = "|";
            line.textAlign = Center;
            line.scale(6);

            place += 110;
        }
    }

    public function getSound() {
        return sound;
    }


}