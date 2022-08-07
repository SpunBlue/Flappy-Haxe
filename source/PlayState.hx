package;

import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var player:Player;

	var pipeTop:FlxSprite;
	var pipeBottom:FlxSprite;
	var pipePieceBottom:FlxSprite;
	var pipePieceTop:FlxSprite;
	var scoreUI:FlxText;

	var creatingPipe:Bool = false;

	var pipesGroup = new FlxTypedGroup<FlxSprite>();
	var scoreDetectors:Array<FlxSprite> = new Array<FlxSprite>();

	var uiTextGroup = new FlxTypedGroup<FlxText>();

	var allowPipeCreation = true;

	var random:Int;

	public static var score:Int = 0;

	var prevScore:Int = -1;

	override public function create()
	{
		super.create();

		var backgroundCol:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF96FFFF);
		add(backgroundCol);

		/*var background:FlxSprite = new FlxSprite(0, 0, AssetPaths.mobilebg__png);
		background.setGraphicSize(FlxG.width, FlxG.height);
		background.updateHitbox();
		add(background);*/

		var sun:FlxSprite = new FlxSprite(FlxG.width - (128 + 24), 24).makeGraphic(128, 128, FlxColor.YELLOW);
		add(sun);

		var grass:FlxSprite = new FlxSprite(0, FlxG.height - 64).makeGraphic(FlxG.width, 64, FlxColor.GREEN);
		add(grass);

		scoreUI = new FlxText(0, 0, FlxG.width, "0");
		scoreUI.setFormat(AssetPaths.prstart__ttf, 64, 0xFFFFFFFF, "center");
		scoreUI.y = FlxG.height - scoreUI.height;
		uiTextGroup.add(scoreUI);
		add(scoreUI);

		player = new Player(FlxG.width * 0.5, FlxG.height * 0.5);
		add(player);

		add(pipesGroup);
		add(uiTextGroup);

		createPipe();
	}

	override public function update(elapsed:Float)
	{
		player.updateMovement();

		super.update(elapsed);

		scoreUI.text = "" + score;

		if (!creatingPipe){
			// create a timer with a function
			var timer:FlxTimer = new FlxTimer();
			timer.start(3, function(timer){
				createPipe();
				creatingPipe = false;
			});

			creatingPipe = true;
		}

		checkPipes();

		if (player.y <= 0 || player.y >= FlxG.height - 124)
		{
			FlxG.switchState(new GameOverState());
		}
	}

	function checkPipes(){
		for (member in pipesGroup.members){
			member.velocity.x = -125;

			if (player.overlaps(member)){
				FlxG.switchState(new GameOverState());
			}

			if (!member.isOnScreen() && member.x <= 0){
				member.kill();

				pipesGroup.members.remove(member);
			}
		}

		for (scoreDetect in scoreDetectors){
			scoreDetect.velocity.x = -125;

			if (player.overlaps(scoreDetect)){
				FlxG.sound.play(AssetPaths.bing__wav, 1, false);
				score++;

				scoreDetect.kill();
				scoreDetectors.remove(scoreDetect);
			}
		}
	}

	function createPipe()
	{
		random = FlxG.random.int(384, FlxG.height - 256);

		pipeBottom = new FlxSprite(0, 0, AssetPaths.pipe__png);
		pipeBottom.setGraphicSize(96, random);
		pipeBottom.updateHitbox();
		pipeBottom.x = FlxG.width + 64;
		pipeBottom.y = FlxG.height - pipeBottom.height + 24;
		pipesGroup.add(pipeBottom);

		pipeTop = new FlxSprite(0, 0, AssetPaths.pipe__png);
		pipeTop.setGraphicSize(96, (FlxG.height - random) - 96);
		pipeTop.updateHitbox();
		pipeTop.x = FlxG.width + 64;
		pipesGroup.add(pipeTop);

		pipePieceBottom = new FlxSprite(0, 0, AssetPaths.pipePiece__png);
		pipePieceBottom.setGraphicSize(124, 48);
		pipePieceBottom.updateHitbox();
		pipePieceBottom.x = pipeBottom.x + (pipeBottom.width * 0.5) - (pipePieceBottom.width * 0.5);
		pipePieceBottom.y = pipeBottom.y;
		pipesGroup.add(pipePieceBottom);

		pipePieceTop = new FlxSprite(0, 0, AssetPaths.pipePiece__png);
		pipePieceTop.setGraphicSize(124, 48);
		pipePieceTop.updateHitbox();
		pipePieceTop.x = pipeTop.x + (pipeTop.width * 0.5) - (pipePieceTop.width * 0.5);
		pipePieceTop.y = pipeTop.y + pipeTop.height - pipePieceTop.height;
		pipesGroup.add(pipePieceTop);

		var sillyScore:FlxSprite = new FlxSprite(pipeBottom.x + pipeBottom.width * 0.5, 0).makeGraphic(32, FlxG.height, FlxColor.ORANGE);
		sillyScore.visible = false;
		add(sillyScore);
		scoreDetectors.push(sillyScore);
	}
}
