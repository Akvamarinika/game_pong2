import scenes.*;

class Main extends hxd.App {
    public var currentScene: MyScene;

    override function init() {
        hxd.Res.initEmbed();    //инициализация загрузчика ресурсов
        @:privateAccess haxe.MainLoop.add(() -> {});

        currentScene = new StartScene(this, hxd.Res.background.toTile());
        currentScene.setScene(currentScene);
    }

    override function update(dt: Float) {
        super.update(dt);
        currentScene.update(dt);
    }

    static function main() {
        new Main();
    }
}