package
{
	import org.flixel.*;

	public class LevelState extends FlxState
	{
		//[Embed(source = "assets/fonts/fibo.ttf", fontName = "FibographyPersonalUse", embedAsCFF="false", mimeType="application/x-font")]
		//private var FontClass:Class;
		
		//[Embed(source = "assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF="false", mimeType="application/x-font")]
		//private var FontClass2:Class;
		
		[Embed(source = "../assets/minitilemap.png")] private var _tileMapPreview:Class;
		
		private var _levelMap:FlxSprite;
		private var _levelName:FlxText;
		
		private var _currentLevel:uint;
		private var _mapPreview:FlxTilemap;
		private var _whiteBorder:WhiteBorder;
		private var _zoomBorder:ZoomBorder;
		
		public function LevelState()
		{
			
		}
		
		override public function create():void
		{
			_currentLevel = 1;
			
			
			_levelName = new FlxText(0, 0, 300, LevelDataManager.getLevelData(_currentLevel).name);
			_levelName.size = 40;
			_levelName.alignment = "center";
			_levelName.x = FlxG.width / 2 - _levelName.width / 2;
			_levelName.y = 450;
			
			setTileMapPreview();
			
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
			if(_currentLevel >= LevelDataManager.levelDataListLength)
			{
				_currentLevel = 0;
			}
			_currentLevel++;
			
			setTileMapPreview();
		}
		
		private function setTileMapPreview():void
		{
			if(_mapPreview != null)
				remove(_mapPreview);
			_mapPreview = new FlxTilemap();
			
			_mapPreview.x = (FlxG.width / 2) - (_mapPreview.widthInTiles / 2) * 16;
			_mapPreview.y = (FlxG.height / 2) - (_mapPreview.heightInTiles / 2) * 16;
			_mapPreview.loadMap(LevelDataManager.getLevelData(_currentLevel).layers[0], _tileMapPreview, 16, 16);
			_levelName.text = LevelDataManager.getLevelData(_currentLevel).name;
			
			_whiteBorder = new WhiteBorder(_mapPreview.width, _mapPreview.height);
			_zoomBorder = new ZoomBorder(_mapPreview.width, _mapPreview.height);
			
			_whiteBorder.x = (FlxG.width / 2) - (_mapPreview.widthInTiles / 2) * 16;
			_whiteBorder.y = (FlxG.height / 2) - (_mapPreview.heightInTiles / 2) * 16;
			
			
			add(_mapPreview);
			//add(_whiteBorder);
			//add(_zoomBorder);
		}
		
		private function previousLevel():void
		{
			if(_currentLevel <= 1)
			{
				_currentLevel = LevelDataManager.levelDataListLength + 1;
			}
			_currentLevel--;
			
			setTileMapPreview();
		}
	}
}