package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MainMenuState extends FlxState
{
	override public function create()
	{
		super.create();

		// create title screen text
		var titleText:FlxText = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "FLAPPY HAXE");
		titleText.setFormat(null, 32, 0xFFFFFFFF, "center");
		add(titleText);

		// create start game button
		var startButton:FlxButton = new FlxButton(FlxG.width / 2 - 50, FlxG.height / 2 + 50, "START", startGame);
		add(startButton);

		// credits
		var creditsText:FlxText = new FlxText(0, FlxG.height - 20, FlxG.width, "by: SpunBlue");
		creditsText.setFormat(null, 8, 0xFFFFFFFF, "center");
		add(creditsText);

		// settings button
		/*var settingsButton:FlxButton = new FlxButton(FlxG.width / 2 - 50, FlxG.height / 2 + 100, "Settings", settingsButt);
			add(settingsButton); */
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function startGame()
	{
		FlxG.switchState(new PlayState());
	}

	function settingsButt()
	{
		#if desktop
		FlxG.switchState(new SettingsState());
		#end
	}
}
