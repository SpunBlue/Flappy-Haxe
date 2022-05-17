package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import openfl.system.System;

class MainMenuState extends FlxState
{
	override public function create()
	{
		super.create();

		// create title screen text
		var titleText:FlxText = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "FLAPPY HAXE");
		titleText.setFormat(AssetPaths.prstart__ttf, 32, 0xFFFFFFFF, "center");
		add(titleText);

		// create start game button
		var startButton:FlxButton = new FlxButton(FlxG.width / 2 - 50, FlxG.height / 2 + 50, "START", startGame);
		add(startButton);

		// credits
		var creditsText:FlxText = new FlxText(0, FlxG.height - 20, FlxG.width, "by: SpunBlue");
		creditsText.setFormat(AssetPaths.prstart__ttf, 8, 0xFFFFFFFF, "center");
		add(creditsText);

		// exit game button
		var exitButton:FlxButton = new FlxButton(FlxG.width - 50, 0, "X", exitGame);
		add(exitButton);

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

	function exitGame()
	{
		System.exit(0);
	}
}
