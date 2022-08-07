package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		#if desktop
		addChild(new FlxGame(0, 0, MainMenuState, 1, 60, 60));
		#else
		addChild(new FlxGame(0, 0, MainMenuState, 1, 30, 30));
		#end
	}
}
