package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
#if desktop
import flixel.util.FlxColor;
import lime.ui.MouseCursor;

class SettingsState extends FlxState
{
	var options = ["Null"];

	var optionGroup = new FlxTypedGroup<FlxText>();

	var lastOptionY:Float = 0;

	var option:FlxText;
	var mouseCursor:FlxSprite;

	override public function create()
	{
		super.create();

		// create mouse object
		mouseCursor = new FlxSprite().makeGraphic(1, 1, FlxColor.RED);

		createOptions();
	}

	override public function update(elapsed:Float)
	{
		mouseCursor.x = FlxG.mouse.x;
		mouseCursor.y = FlxG.mouse.y;

		super.update(elapsed);

		if (mouseCursor.overlaps(option) && FlxG.mouse.justPressed)
		{
			switch (option.text.toLowerCase())
			{
				case "back":
					FlxG.switchState(new MainMenuState());
			}
		}
	}

	function detectOptionType(type:String = 'default')
	{
		switch (type)
		{
			default:
				options = ["Gameplay", "Video", "Save Data", "Back"];
		}
	}

	function createOptions(tempType:String = 'default')
	{
		lastOptionY = 0;

		detectOptionType(tempType);

		for (i in 0...options.length)
		{
			option = new FlxText(0, lastOptionY + 64, FlxG.width, options[i]);
			option.setFormat("Arial", 64, 0xffffffff, "left");
			optionGroup.add(option);
			add(option);

			lastOptionY = option.y;
		}
	}
}
#end
