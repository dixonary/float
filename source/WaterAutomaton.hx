package;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

class WaterAutomaton extends FlxSprite
{
    static inline var WIDTH:Int = 100;
    static inline var HEIGHT:Int = 100;
    static inline var RANGE:Int = 256;
    var map:Array<Array<Int>> = [];

    public function new()
    {
        super();
        for (i in 0 ... WIDTH) {
            map[i] = [];
            for (j in 0 ... HEIGHT) {
                map[i][j] = 0;
            }
        }
        makeGraphic(WIDTH, HEIGHT, 0xFF<<24);
    }

    public override function draw():Void
    {
        for (i in 0 ... WIDTH) {
            for (j in 0 ... HEIGHT) {
                var c = (map[i][j] + Std.int(RANGE / 2));
                FlxSpriteUtil.drawRect(this, i, j, 1, 1,
                                       (0xFF << 24) + c * 0x10101);
            }
        }
        super.draw();
    }
}
