package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;

typedef Cell = Int;
typedef Neighbours = Array<Null<Cell>>;

class WaterAutomaton extends FlxGroup
{
    static inline var WIDTH:Int = 100;
    static inline var HEIGHT:Int = 100;
    static inline var RANGE:Int = 127;
    static inline var CELL_SIZE:Int = 5;
    var lastMap:Array<Array<Cell>> = [];
    var map:Array<Array<Cell>> = [];

    var tiles:FlxTilemap;

    public function new(_x:Int = 200, _y:Int = 200) {
        super();

        //Initialise tilemap
        var tilemapInitStr = "";
        for(i in 0 ... HEIGHT) {
            for (j in 0 ... WIDTH) {
                tilemapInitStr += "0";
                if(j < WIDTH-1) {
                    tilemapInitStr += ",";
                }
            }
            if(i < HEIGHT-1) {
                tilemapInitStr += "\n";
            }
        }
        tiles = new FlxTilemap().loadMap(tilemapInitStr, "assets/images/tiles.png", 1, 1);
        tiles.scale.x =
        tiles.scale.y = CELL_SIZE;
        tiles.x = _x; tiles.y = _y;
        add(tiles);

        for (i in 0 ... WIDTH) {
            map[i] = [];
            for (j in 0 ... HEIGHT) {
                map[i][j] = 0;
                drawCell(i, j);
            }
        }
    }

    public override function update():Void {
        if (FlxG.mouse.pressed) {
            var cellX = Std.int((FlxG.mouse.screenX - tiles.x) / CELL_SIZE);
            var cellY = Std.int((FlxG.mouse.screenY - tiles.y) / CELL_SIZE);
            triggerWave(cellX,cellY);
        }

        lastMap = map;
        map = [];

        for (i in 0 ... WIDTH) {
            map[i] = [];
            for (j in 0 ... HEIGHT) {
                map[i][j] = zed0rule(lastMap[i][j], fourNeighbours(i, j));

                if(map[i][j] != lastMap[i][j]) {
                    drawCell(i, j);
                }
            }
        }
    }

    function drawCell(_i, _j) {
        var c = map[_i][_j] + RANGE;
        tiles.setTile(_j, _i, c);
    }

    function zed0rule(oldCell:Cell, ns: Neighbours):Cell {
        var newCell:Cell;
        var nbar:Cell = 0;
        for (n in ns) {
            if (n != null) {
                nbar += n;
            } else {
                nbar += oldCell;
            }
        }
        nbar = Std.int(nbar / 2);
        newCell = nbar - oldCell;
        newCell = Std.int(FlxMath.bound(newCell, -RANGE, RANGE));

        return newCell;
    }

    public function triggerWave(_i:Int, _j:Int) {
        if (_i >= 0 && _i < WIDTH  && _j >= 0 && _j < HEIGHT) {
            map[_i][_j] = -RANGE;
        }
    }

    function fourNeighbours(_i:UInt, _j:UInt):Neighbours {
        var neighbours:Array<Null<Int>> = [null, null, null, null];
        if (_i > 0) {
            neighbours[0] = lastMap[_i - 1][_j];
        }
        if (_i < WIDTH - 1) {
            neighbours[2] = lastMap[_i + 1][_j];
        }
        if (_j > 0) {
            neighbours[1] = lastMap[_i][_j - 1];
        }
        if (_j < HEIGHT - 1) {
            neighbours[3] = lastMap[_i][_j + 1];
        }
        return neighbours;
    }
}
