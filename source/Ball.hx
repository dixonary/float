package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxSpriteUtil;

class Ball extends FlxSprite {

    function new() {
        super();

        x = FlxG.width/2;
        acceleration.x = 4000;

        makeGraphic(100,100,0x00000000);
        FlxSpriteUtil.drawCircle(this, 50, 50, 50, 0xffff0000);
    }

    public override function update():Void {
        super.update();
        if(x+width > FlxG.width) {
            velocity.x = -Math.abs(velocity.x);
        }
        if(x < 0) {
            velocity.x = Math.abs(velocity.x);
        }
    }



}