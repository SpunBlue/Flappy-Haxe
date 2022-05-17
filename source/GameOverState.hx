package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

class GameOverState extends FlxState
{
	var accept:Bool = false;
	var highScore:Int = FlxG.save.data.highScore;

	override public function create()
	{
		var gameOverText:FlxText = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "Game Over");
		gameOverText.setFormat(AssetPaths.prstart__ttf, 50, 0xffffffff, "center");
		add(gameOverText);

		var scoreText:FlxText = new FlxText(0, FlxG.height / 2, FlxG.width, "Score: " + PlayState.score);
		scoreText.setFormat(AssetPaths.prstart__ttf, 20, 0xffffffff, "center");
		add(scoreText);

		if (PlayState.score > highScore)
		{
			FlxG.save.data.highScore = PlayState.score;
			FlxG.save.flush();

			var newHighScoreText:FlxText = new FlxText(0, FlxG.height / 2 + 100, FlxG.width, "New High Score!");
			newHighScoreText.setFormat(AssetPaths.prstart__ttf, 20, 0xffffffff, "center");
			add(newHighScoreText);
		}

		var highScoreText:FlxText = new FlxText(0, FlxG.height / 2 + 50, FlxG.width, "High Score: " + highScore);
		highScoreText.setFormat(AssetPaths.prstart__ttf, 20, 0xffffffff, "center");
		add(highScoreText);

		var enterText:FlxText = new FlxText(0, FlxG.height / 2 + 150, FlxG.width, "Press Enter or Tap to Play Again");
		enterText.setFormat(AssetPaths.prstart__ttf, 20, 0xffffffff, "center");
		add(enterText);
	}

	override public function update(elapsed)
	{
		super.update(elapsed);

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
				accept = true;
		}
		#else
		accept = FlxG.keys.anyJustPressed([SPACE, ENTER]) || FlxG.mouse.justPressed;
		#end

		if (accept)
		{
			PlayState.score = 0;
			FlxG.switchState(new PlayState());
		}
	}
}
