package
{
	import org.flixel.*;

	public class LevelState extends FlxState
	{
		/*
		[Embed(source = "assets/fonts/fibo.ttf", fontName = "FibographyPersonalUse", embedAsCFF="false", mimeType="application/x-font")]
		private var FontClass:Class;
		
		[Embed(source = "assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF="false", mimeType="application/x-font")]
		private var FontClass2:Class;
		*/
		
		private var _levelMap:FlxSprite;
		private var _levelName:FlxText;
		
		private var _currentLevel:uint;
		
		public function LevelState()
		{
			_currentLevel = 1;
			
			_levelMap = new FlxSprite();
			_levelMap.makeGraphic(300, 300, 0xffff0000);
			_levelMap.x = FlxG.width / 2 - _levelMap.width / 2;
			_levelMap.y = 100;
			
			_levelName = new FlxText(0, 0, 300, "What's this?");
			//_levelName.setFormat("AldotheApache");
			_levelName.size = 40;
			_levelName.alignment = "center";
			_levelName.x = FlxG.width / 2 - _levelName.width / 2;
			_levelName.y = 450;
			
			loadLevel(LevelDataManager.getLevelData(_currentLevel));
			
			add(_levelMap);
			add(_levelName);
		}
		
		override public function update():void
		{
			if(FlxG.keys.justPressed("LEFT"))
			{
				previousLevel();
			}
			else if(FlxG.keys.justPressed("RIGHT"))
			{
				nextLevel();
			}
			
			if(FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new GameState(_currentLevel));
			}
		}
		
		private function loadLevel(data:LevelData):void
		{
			_levelName.text = data.name;
		}
		
		private function nextLevel():void
		{
			if(_currentLevel <= LevelDataManager.levelList.length)
			{
				loadLevel(LevelDataManager.getLevelData(++_currentLevel));
			}
		}
		
		private function previousLevel():void
		{
			if(_currentLevel <= 1)
			{
				loadLevel(LevelDataManager.getLevelData(++_currentLevel));
			}
		}
	}
}