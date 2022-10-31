package objects;

import h2d.Bitmap;
import h2d.Tile;
import h2d.Object;
import hxd.Window;
import h2d.Particles;

class Ball extends Object{
    public final SCALE_VALUE = 0.01;
    public final START_VELOCITY = new Vector2d(8, 5);
    public final TIME_VELOCITY = 5;
    public static var currentVel = new Vector2d(8, 5);
    public static var staticBall: Ball = null;
    public var bitmap: Bitmap;

    var accelleration = new Vector2d(0.5, 0.2);
    public var velocity: Vector2d;
    public var direction = new Vector2d();
    public var maxVelocity : Vector2d;
    private var currentSpeedTimer: Float;
    public var friction = 1;
    public var isBallThrown: Bool = false;
    
    
    public function new(?parent: Object) {
        staticBall == null ? staticBall = this : remove();

        super(parent); //Object-parent
        var tile: Tile = hxd.Res.ballImg.toTile();
        this.setImage(tile, parent);
        this.bitmap.scale(SCALE_VALUE);
        this.takeStartingPosition();

        velocity = currentVel;

        maxVelocity = START_VELOCITY.mul(2);
        currentSpeedTimer = TIME_VELOCITY;

    }

    private function setImage(tile: Tile, ?parent: Object) {
		bitmap = new Bitmap(tile, parent);
		bitmap.tile.dx = -tile.width / 2; //размещение центра Плитки в координатах (0, 0) левый верхний угол
		bitmap.tile.dy = -tile.height / 2;
    }

    public function takeStartingPosition() {
        this.setPosition(Window.getInstance().width / 2, Window.getInstance().height / 2);
        direction = new Vector2d();
        velocity = START_VELOCITY;
        isBallThrown = false;
        this.x = Window.getInstance().width / 2;
        this.y = Window.getInstance().height / 2;
    }

    public function update(dt: Float) {
        if (currentVel.x < START_VELOCITY.x || currentVel.y < START_VELOCITY.y) {
            currentVel = new Vector2d(8, 5);
            velocity = START_VELOCITY;
        }

       direction.norm();
        this.setPosition(x + direction.x * velocity.x, y + direction.y * velocity.y);
        //this.velocity.y = this.velocity.y * (1 - Math.min(dt * this.friction, 1));
        //this.velocity.y = this.velocity.y + 10 * dt;
        this.bitmap.x = x;
		this.bitmap.y = y;

        this.checkGameSceneCollisions(dt);
    }

    //рандомно бросить мяч одному из игроков
    public function throwBall() {
        isBallThrown ? return : isBallThrown = true;

        var randomNumber = Random.float(-1, 1);
        randomNumber > 0 ? direction.x = 1 : direction.x = -1;
    }

    private function checkGameSceneCollisions(dt) {
        var height = this.bitmap.tile.height / 2 * this.bitmap.scaleY;
        direction.norm();
        this.bitmap.rotation += 0.1 * direction.x * velocity.x;

        //при столкновении со стенами (лево / право):
        if (x > Window.getInstance().width) {
            Score.score.updatePlayerScore();
            this.updateVelocity(2, 1);
            hxd.Res.btnpressed.play();
            this.takeStartingPosition();
        } else if (x < 0) {
            Score.score.updateCPUScore();
            this.updateVelocity(2, 1);
            hxd.Res.btnpressed.play();
            this.takeStartingPosition();
        }

        //при столкновении со стенами (верх / низ):
        if (this.getBounds().y < 0) {
            this.direction.y = Math.abs(this.direction.y );
            this.addAccelleration(dt);
        }

        if (this.getBounds().y + this.getBounds().height > Window.getInstance().height) {
            this.direction.y = -Math.abs(this.direction.y);
            this.addAccelleration(dt);
        }

	}


    public function updateVelocity(numberX, numberY) {

           if (this.isBallThrown) {

   

                currentVel.x = numberX;
                currentVel.y = numberY;

                velocity.x += currentVel.x;
                velocity.y += currentVel.y;
            }

            if (velocity.x > maxVelocity.x) {
                velocity.x = maxVelocity.x;
            }

            if (velocity.y > maxVelocity.y) {
                velocity.y = maxVelocity.y;
            }

            if (rotation > 0) {
                rotation -= Math.PI;
            } else {
                rotation += Math.PI;
            }
    
            rotation = -rotation;
        
    }


    public function getBoundsBitmap() {
        return bitmap.getBounds();
       }

       override function onRemove() {
        super.onRemove();
        staticBall = null;
    }


    public function addAccelleration(dt: Float) {
        if (this.isBallThrown) {
            currentSpeedTimer -= dt;
            if (currentSpeedTimer <= 0) {
                this.accelleration = accelleration.mul(0);
                currentSpeedTimer = TIME_VELOCITY;
            } 

            velocity.x += accelleration.x * dt;
            velocity.y += accelleration.y * dt;
        }    
    }

    public  function createParticles() {
        var particleSystem = new Particles(parent);
        var particleGroup = new ParticleGroup(particleSystem);
        particleGroup.emitLoop = false;
        particleGroup.life = 0.2;
        //particleGroup.lifeRand = 0.2;
        particleGroup.fadeIn = 0;
        particleGroup.fadeOut = 2;
        particleGroup.fadePower = 5;
        particleGroup.size = 0.1;
        particleGroup.nparts = 15;
        particleGroup.speed = 100;
        particleGroup.gravity = 12;
        particleGroup.texture = hxd.Res.star.toTexture();
        
        particleSystem.setPosition(this.x, this.y);
        particleSystem.addGroup(particleGroup);
        particleSystem.onEnd = function() {
            particleSystem.removeGroup(particleGroup);
        }
    }



}   