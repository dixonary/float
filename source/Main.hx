package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;
import openfl.Assets;

class Main extends Sprite
{
    var initialState:Class<FlxState> = MenuState; // The FlxState the game starts with.
    var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
    var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.
    var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
    // You can pretty much ignore everything from here on - your code should go in your states.

    public static function main():Void
    {
        Lib.current.addChild(new Main());
    }

    public function new()
    {
        super();

        if (stage != null)
        {
            init();
        }
        else
        {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }
    }

    private function init(?E:Event):Void
    {
        if (hasEventListener(Event.ADDED_TO_STAGE))
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
        }

        setupGame();
    }

    private function setupGame():Void
    {
        var stageWidth:Int = Lib.current.stage.stageWidth;
        var stageHeight:Int = Lib.current.stage.stageHeight;

        addChild(new GameClass());
    }

}