package;

import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

class WaterAutomaton extends FlxSprite
{
    static inline var WIDTH:Int = 100;
    static inline var HEIGHT:Int = 100;
    static inline var RANGE:Int = 127;
    static inline var CELL_SIZE:Int = 10;
    var map:Array<Array<Int>> = [];

    public function new() {
        super();
        for (i in 0 ... WIDTH) {
            map[i] = [];
            for (j in 0 ... HEIGHT) {
                map[i][j] = 0;
            }
        }
        makeGraphic(WIDTH, HEIGHT, 0xFF<<24);
        this.scale = new flixel.util.FlxPoint(CELL_SIZE, CELL_SIZE);
    }

    public override function update():Void {
        var newMap:Array<Array<Int>> = [];

        for (i in 0 ... WIDTH) {
            newMap[i] = [];
            for (j in 0 ... HEIGHT) {

                var neighbourAverage:Int = 0;
                var currentValue = map[i][j];

                for (cell in fourNeighbours(i,j)) {
                    if (cell != null) {
                        neighbourAverage += cell;
                    } else {
                        neighbourAverage += currentValue;
                    }
                }

                neighbourAverage = Std.int(neighbourAverage / 2);
                newMap[i][j] = neighbourAverage - currentValue;
                if (newMap[i][j] > RANGE) {
                    newMap[i][j] = RANGE;
                }
                if (newMap[i][j] < -RANGE) {
                    newMap[i][j] = -RANGE;
                }
            }
        }

        map = newMap;
    }

    public function triggerWave(_i:Int, _j:Int) {
        if (_i >= 0 && _i < WIDTH  && _j >= 0 && _j < HEIGHT) {
            map[_i][_j] += 1;
        }
    }

    function fourNeighbours(_i:UInt, _j:UInt):Array<Null<Int>> {
        var neighbours:Array<Null<Int>> = [null, null, null, null];
        if (_i > 0) {
            neighbours[0] = map[_i - 1][_j];
        }
        if (_i < WIDTH - 1) {
            neighbours[2] = map[_i + 1][_j];
        }
        if (_j > 0) {
            neighbours[1] = map[_i][_j - 1];
        }
        if (_j < HEIGHT - 1) {
            neighbours[3] = map[_i][_j + 1];
        }
        return neighbours;
    }

    public override function draw():Void {
        for (i in 0 ... WIDTH) {
            for (j in 0 ... HEIGHT) {
                var c = map[i][j] + RANGE;
                FlxSpriteUtil.drawRect(this, i, j, 1, 1, 0xFF000000 + c * 0x10101);
            }
        }
        super.draw();
    }
}
