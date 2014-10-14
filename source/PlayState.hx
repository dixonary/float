package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

    inline private static var TILES_X:Int = 30;
    inline private static var TILES_Y:Int = 30;

    var water:WaterAutomaton;
    var ball:Ball;
    /**
     * Function that is called up when to state is created to set it up.
     */
    override public function create():Void
    {
        FlxG.mouse.useSystemCursor = true;
        FlxG.fixedTimestep = false;
        super.create();

        water = new WaterAutomaton();
        add(water);

        ball = new Ball();
        add(ball);
    }

    /**
     * Function that is called when this state is destroyed - you might want to
     * consider setting all objects this state uses to null to help garbage collection.
     */
    override public function destroy():Void
    {
        super.destroy();
    }

    /**
     * Function that is called once every frame.
     */
    override public function update():Void
    {
        super.update();
    }
}
