package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic(AssetPaths.player__png, false, 32, 32);
		maxVelocity.y = 500;
		drag.y = 1600;
		setSize(16, 16);
		offset.set(8, 8);
	}

	public function updateMovement()
	{
		var jump:Bool = false;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
				jump = true;
		}
		#else
		jump = FlxG.keys.anyJustPressed([SPACE, W, UP]) || FlxG.mouse.justPressed;
		#end

		if (jump)
		{
			FlxG.sound.play(AssetPaths.flap__wav);
			velocity.y = -250;
			!jump;
		}
		else if (velocity.y <= 1)
		{
			acceleration.y = 500;
		}

		if (velocity.y < 0 && angle > -29)
		{
			angle--;
		}
		else if (angle < 29 && acceleration.y > 0)
		{
			angle++;
		}
		else if (angle > 0 && acceleration.y < 500)
		{
			angle--;
		}
	}
}
