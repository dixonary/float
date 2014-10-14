package;
 
import flash.events.Event;
import flash.Lib;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxCamera;
import flixel.addons.display.FlxZoomCamera;
import flash.events.KeyboardEvent;
	
class ScaledGame extends FlxGame
{
	private var _ratio:Float;
	
	#if flash
		inline static private var GAME_WIDTH:Int = 720;
		inline static private var GAME_HEIGHT:Int = 450;
		inline static public var SCALE_FACTOR = 0.42;
	#else
		inline static private var GAME_WIDTH:Int = 1920;
		inline static private var GAME_HEIGHT:Int = 1080;
		inline static public var SCALE_FACTOR = 1;
	#end

	/**
	 * Sets up our FlxGame class and loads into the MenuState.
	 */
	public function new() {

		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		var ratioX:Float = stageWidth / GAME_WIDTH;
		var ratioY:Float = stageHeight / GAME_HEIGHT;
		
		_ratio = Math.min(ratioX, ratioY);
	
		#if flash
			var updateFPS:Int = 30;
			var renderFPS:Int = 30;
		#else
			var updateFPS:Int = 120;
			var renderFPS:Int = 120;
		#end

		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);

		super(GAME_WIDTH, GAME_HEIGHT, MenuState, _ratio, updateFPS, renderFPS, true);

	}

	private function keyReleased(E:KeyboardEvent):Void {
		if(E.keyCode == 27) {
			E.stopPropagation();
		}
	}
	
	/**
	 * Override the base onResize function to center and stretch the game to fit the screen.
	 */
	override public function onResize(E:Event):Void {

		#if (desktop || android)
			var z:Float = FlxG.camera.zoom;

			var width:Int = FlxG.stage.stageWidth;
			var height:Int = FlxG.stage.stageHeight;

			var rW = width/GAME_WIDTH;
			var rH = height/GAME_HEIGHT;
			var rT = Math.min(rW, rH);

			scaleX = rT;
			scaleY = rT;

			if(rW > rH)
				x = (width-(GAME_WIDTH*rT))/2;
			else
				y = (height-(GAME_HEIGHT*rT))/2;
		#end

		#if flash
			super.onResize(E);
		#end
		
	}
}