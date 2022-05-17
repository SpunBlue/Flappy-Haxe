package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	var player:Player;

	var ground:FlxSprite;
	var pipeTop:FlxSprite;
	var pipeBottom:FlxSprite;
	var pipePieceBottom:FlxSprite;
	var pipePieceTop:FlxSprite;
	var scoreUI:FlxText;

	var pipesGroup = new FlxTypedGroup<FlxSprite>();
	var pipesDetailGroup = new FlxTypedGroup<FlxSprite>();

	var uiTextGroup = new FlxTypedGroup<FlxText>();

	var allowPipeCreation = true;

	var random:Int;

	public static var score:Int = 0;

	var prevScore:Int = -1;

	override public function create()
	{
		super.create();

		// create background
		var backgroundCol:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF96FFFF);
		add(backgroundCol);

		var background:FlxSprite = new FlxSprite(0, 0, AssetPaths.background__png);
		background.setGraphicSize(FlxG.width);
		background.updateHitbox();
		background.setPosition(0, FlxG.height - background.height);
		add(background);

		ground = new FlxSprite(0, 0, AssetPaths.ground__png);
		ground.setGraphicSize(FlxG.width);
		ground.updateHitbox();
		ground.y = FlxG.height - ground.height;
		add(ground);

		scoreUI = new FlxText(0, 0, FlxG.width, "0");
		scoreUI.setFormat("Arial", 64, 0xFFFFFFFF, "center");
		scoreUI.y = FlxG.height - scoreUI.height;
		uiTextGroup.add(scoreUI);
		add(scoreUI);

		player = new Player(24, FlxG.height * 0.5);
		add(player);

		createPipe();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		player.updateMovement();

		scoreUI.text = "" + score;

		if (player.y <= 0 || player.y >= FlxG.height - (ground.height * 0.5))
		{
			FlxG.switchState(new GameOverState());
		}

		for (i in 0...pipesGroup.members.length)
		{
			if (pipesGroup.members[i] != null)
			{
				pipesGroup.members[i].x -= elapsed * 100; // move pipes to the left

				if (pipesGroup.members[i].x <= -pipesGroup.members[i].width)
				{
					pipesGroup.members[i].kill();
					pipesGroup.remove(pipesGroup.members[i]);
					trace("removed pipe");

					prevScore = 0; // reset score!/1/1//!?!?!/1
					allowPipeCreation = true;
				}

				if (pipesGroup.members[i] != null && pipesGroup.members[i].x <= FlxG.width * 0.35 && allowPipeCreation)
				{
					trace("created new pipe");
					createPipe();
					allowPipeCreation = false;
				}
			}
		}

		for (i in 0...pipesDetailGroup.members.length)
		{
			if (pipesDetailGroup.members[i] != null)
			{
				pipesDetailGroup.members[i].x -= elapsed * 100;

				if (pipesDetailGroup.members[i].x <= -pipesDetailGroup.members[i].width)
				{
					pipesDetailGroup.members[i].kill();
					pipesDetailGroup.remove(pipesDetailGroup.members[i]);
					trace("removed pipe top");
				}
			}
		}

		// idk any other way to do this cuz i'm too dumb to figure out how to do it
		for (i in 0...pipesGroup.members.length)
		{
			if (pipesGroup.members[i] != null
				&& pipesGroup.members[i].x <= player.x
				&& pipesGroup.members[i].x >= player.x - pipesGroup.members[i].width)
			{
				if (prevScore != score)
				{
					score++;
					prevScore = score;
					FlxG.sound.play(AssetPaths.bing__wav);
				}
			}

			// game over
			if (pipesGroup.members[i] != null && player.overlaps(pipesGroup.members[i]))
			{
				FlxG.switchState(new GameOverState());
			}
		}
	}

	function createPipe()
	{
		random = FlxG.random.int(384, FlxG.height - 256);

		pipeBottom = new FlxSprite(0, 0, AssetPaths.pipe__png);
		// pipeBottom = new FlxSprite().makeGraphic(96, random, 0xFF37B700);
		pipeBottom.setGraphicSize(96, random);
		pipeBottom.updateHitbox();
		pipeBottom.x = FlxG.width;
		pipeBottom.y = FlxG.height - pipeBottom.height + 24;
		pipesGroup.add(pipeBottom);

		pipeTop = new FlxSprite(0, 0, AssetPaths.pipe__png);
		// pipeTop = new FlxSprite().makeGraphic(96, (FlxG.height - random) - 96, 0xFF37B700);
		pipeTop.setGraphicSize(96, (FlxG.height - random) - 96);
		pipeTop.updateHitbox();
		pipeTop.x = FlxG.width;
		pipesGroup.add(pipeTop);

		pipePieceBottom = new FlxSprite(0, 0, AssetPaths.pipePiece__png);
		pipePieceBottom.setGraphicSize(124, 48);
		pipePieceBottom.updateHitbox();
		pipePieceBottom.x = pipeBottom.x + (pipeBottom.width * 0.5) - (pipePieceBottom.width * 0.5);
		pipePieceBottom.y = pipeBottom.y;
		pipesDetailGroup.add(pipePieceBottom);

		pipePieceTop = new FlxSprite(0, 0, AssetPaths.pipePiece__png);
		pipePieceTop.setGraphicSize(124, 48);
		pipePieceTop.updateHitbox();
		pipePieceTop.x = pipeTop.x + (pipeTop.width * 0.5) - (pipePieceTop.width * 0.5);
		pipePieceTop.y = pipeTop.y + pipeTop.height - pipePieceTop.height;
		pipesDetailGroup.add(pipePieceTop);

		updateLayers();
	}

	function updateLayers()
	{
		add(pipesGroup);
		add(pipesDetailGroup);
		add(uiTextGroup);
	}
}
