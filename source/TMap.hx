package;

import flixel.tile.FlxTilemap;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;

class TMap extends FlxGroup {

    var heights:Array<Array<Float>>;
    var vismap:FlxTilemap;

    var dPress:FlxPoint;

    var w:Int;
    var h:Int;

    public function new(_w:Int, _h:Int) {

        super();

        w = _w;
        h = _h;

        var numCells:Int = _w*_h;

        heights = [];
        //generate zeroed 2d-array
        for(i in 0 ... _w) {
            heights[i] = [];
            for(j in 0 ... _h) {

                heights[i][j] = 0;

            }
        }

        vismap = new FlxTilemap();
        zeroMap();
        add(vismap);

    }

    public function zeroMap():Void {

        var initStr = "";
        //generate 2d initstring
        for(i in 0 ... h) {
            for(j in 0 ... w) {
                initStr += "0";
                if(j < h-1)
                    initStr += ",";
            }
            if(i < w-1)
                initStr += "\n";
        }

        vismap.loadMap(initStr, "assets/images/tilemap.png",32, 32, 0, 0, 0, 0);

    }

    override public function update():Void {

        super.update();

        if(FlxG.mouse.justPressed) {
            if(vismap.overlapsPoint(FlxG.mouse.getWorldPosition())) {
                dPress = FlxG.mouse.getWorldPosition();
            }
        }
        if(FlxG.mouse.justReleased) {
            if(vismap.overlapsPoint(FlxG.mouse.getWorldPosition())) {
                var maxPoints:Int = vismap.widthInTiles*vismap.heightInTiles;
                var mpos:FlxPoint = FlxG.mouse.getWorldPosition();
                var dx:Float = mpos.x - dPress.x;
                var dy:Float = mpos.y - dPress.y;
                for (i in 0 ... maxPoints+1) {
                    var p:FlxPoint = new FlxPoint(i/maxPoints*dx + dPress.x, i/maxPoints*dy + dPress.y);
                    vismap.setTile(Math.floor((p.x-vismap.x)/32), Math.floor((p.y-vismap.y)/32),1);
                }
            }
        }

        if(FlxG.keys.anyJustPressed(["SPACE"])) {
            zeroMap();
        }

    }

}