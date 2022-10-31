package objects;

import hxd.Window;
import h2d.Object;
import scenes.*;

class Score extends h2d.Text {
    var SCORE_WIN = 9;
    var scene: MyScene;
    var main: Main;
    public var playerScore = 0;
    public var cpuScore = 0;
    public static var score: Score = null;

   
    public function new(?parent: Object, scene: MyScene, main: Main) {
        score == null ? score = this : remove();

        this.scene = scene;
        this.main = main;

        super(hxd.Res.font.toFont(), parent);
        textAlign = Center;
        scale(6);
        this.updateText();
    }

    function updateText() {
        text = '$playerScore              $cpuScore';
    }

    public function updatePlayerScore() {
        playerScore += 1;
        this.updateText();
        
        if (playerScore >= SCORE_WIN) {
            var gameScene = cast(scene, GameScene);
            gameScene.getSound().stop();

            var winScene = new WinScene(main, hxd.Res.background.toTile());
            scene.setScene(winScene);
        }
    }

    public function updateCPUScore() {
        cpuScore += 1;
        this.updateText();

        if (cpuScore >= SCORE_WIN) {
            var gameScene = cast(scene, GameScene);
            gameScene.getSound().stop();

            var looseScene = new LooseScene(main, hxd.Res.background.toTile());
            scene.setScene(looseScene);
            //trace(getScene());
        }
    }

    override function onRemove() {
        super.onRemove();
        score = null;
    }


}    