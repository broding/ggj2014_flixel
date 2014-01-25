package
{
	import org.flixel.*;

	public class LevelState extends FlxState
	{
		//[Embed(source = "assets/fonts/fibo.ttf", fontName = "FibographyPersonalUse", embedAsCFF="false", mimeType="application/x-font")]
		//private var FontClass:Class;
		
		//[Embed(source = "assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF="false", mimeType="application/x-font")]
		//private var FontClass2:Class;
		
		private var _levelMap:FlxSprite;
		private var _levelName:FlxText;
		
		private var _currentLevel:uint;
		private var _mapPreview:Level;
		
		public function LevelState()
		{
			
		}
		
		override public function create():void
		{
			_currentLevel = 1;
			
			_mapPreview = new Level();
			_mapPreview.LoadLevelData(LevelDataManager.getLevelData(_currentLevel));
			
			_levelName = new FlxText(0, 0, 300, LevelDataManager.getLevelData(_currentLevel).name);
			_levelName.size = 40;
			_levelName.alignment = "center";
			_levelName.x = FlxG.width / 2 - _levelName.width / 2;
			_levelName.y = 450;
			
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
			_mapPreview = new Level();
			if(_currentLevel >= LevelDataManager.levelDataListLength)
			{
				_currentLevel = 0;
			}
			_mapPreview.LoadLevelData(LevelDataManager.getLevelData(++_currentLevel));
		}
		
		private function previousLevel():void
		{
			_mapPreview = new Level();
			if(_currentLevel <= 1)
			{
				_currentLevel = LevelDataManager.levelDataListLength + 1;
			}
			_mapPreview.LoadLevelData(LevelDataManager.getLevelData(--_currentLevel));
		}
	}
}