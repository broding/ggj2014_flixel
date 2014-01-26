package
{
	import org.flixel.*;

	public class LevelState extends FlxState
	{
		//[Embed(source = "assets/fonts/fibo.ttf", fontName = "FibographyPersonalUse", embedAsCFF="false", mimeType="application/x-font")]
		//private var FontClass:Class;
		
		
		[Embed(source = "../assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF="false", mimeType="application/x-font")]
		private var FontClass2:Class;
		
		[Embed(source="../assets/miniblue.png")] private var blue:Class;
		[Embed(source="../assets/minired.png")] private var red:Class;
		[Embed(source="../assets/minigreen.png")] private var green:Class;
		
		
		private var _levelMap:FlxSprite;
		private var _levelName:FlxText;
		
		private var _currentLevel:uint;
		private var _mapPreviews:FlxGroup;
		private var _whiteBorders:FlxGroup;
		private var _zoomBorder:ZoomBorder;
		
		public function LevelState()
		{
			
		}
		
		override public function create():void
		{
			FlxG.flash();
			_currentLevel = 1;
			
			
			_levelName = new FlxText(0, 0, 300, LevelDataManager.getLevelData(_currentLevel).name);
			_levelName.setFormat("AldotheApache", 40);
			_levelName.size = 40;
			_levelName.alignment = "center";
			_levelName.x = FlxG.width / 2 - _levelName.width / 2;
			_levelName.y = 450;
			
			_mapPreviews = new FlxGroup();
			_whiteBorders =  new FlxGroup();
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
			_mapPreviews.clear();
			_whiteBorders.clear();
			
			_mapPreviews = new FlxGroup();
			_whiteBorders =  new FlxGroup();
			
			for (var i:int = 0; i < LevelDataManager.getLevelData(_currentLevel).layers.length; i++)
			{
				_mapPreviews.add(new FlxTilemap());
				_mapPreviews.members[i].loadMap(LevelDataManager.getLevelData(_currentLevel).layers[i],this.getLayerColor(i), 16, 16);
				_mapPreviews.members[i].x = (FlxG.width / 2) + ((i * _mapPreviews.members[i].widthInTiles * 16) + (i * 20)) - (((LevelDataManager.getLevelData(_currentLevel).layers.length / 2) * _mapPreviews.members[i].widthInTiles * 16) + (((LevelDataManager.getLevelData(_currentLevel).layers.length - 1) / 2) * 20));
				_mapPreviews.members[i].y = (FlxG.height / 2) - (_mapPreviews.members[i].heightInTiles / 2) * 16;
				
				_whiteBorders.add(new WhiteBorder(_mapPreviews.members[i].width, _mapPreviews.members[i].height, _mapPreviews.members[i].x, _mapPreviews.members[i].y));
			}
			
			_levelName.text = LevelDataManager.getLevelData(_currentLevel).name;
			
			add(_mapPreviews);
			add(_whiteBorders);
		}
		
		private function getLayerColor(index:uint):Class
		{
			switch(index)
			{
				case 0:
					return blue;
					break;
				case 1:
					return red;
					break;
				case 2:
					return green;
					break;
			}
			
			return blue;
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