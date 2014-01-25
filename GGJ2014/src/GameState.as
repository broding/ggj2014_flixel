package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class GameState extends FlxState
	{
		public static var tileSize:int = 64;
		
		[Embed(source = '../assets/TELEPORTER MAN Tiles.png')]private var tiles_img:Class;
		[Embed(source = '../assets/CSV_Level_1.txt', mimeType = 'application/octet-stream')]private var lvl_1:Class;
		private var level:Level;
		private var _currentLevel:uint;
		
		private var _player:Player;
		private var _wallbreakers:FlxGroup = new FlxGroup();
		
		public function GameState(selectedLevel:uint) 
		{
			super();
			
			_currentLevel = selectedLevel;
		}
		override public function create():void 
		{	
			level = new Level();
			level.LoadLevelData(LevelDataManager.getLevelData(_currentLevel));
			
			add(_wallbreakers);
			
			_player = new Player(level.spawn.x, level.spawn.y);
			add(_player);
			
			FlxG.camera.scroll.x = level.width / 2 - FlxG.width / 2;
			FlxG.camera.scroll.y = level.height / 2 - FlxG.height / 2;
			
			super.create();
		}
		
		override public function update():void 
		{
			FlxG.collide(_player, level.layers[level.currentLayer], CollidePlayerLevel);
			
			FlxG.overlap(_player, level.switches, OverlapPlayerSwitch);
			FlxG.overlap(_player, level.endPortal, OverlapPlayerPortal);
			
			if (FlxG.keys.justPressed("SPACE") && !_player.moving) {
				var tileindex:int = Math.floor(_player.x / 64) + (Math.floor(_player.y / 64) * level.layers[level.currentLayer].widthInTiles);
				ToggleWallbreaker(tileindex);
			}
			super.update();
		}
		
		private function ToggleWallbreaker(tileindex:int):void {
			var exists:Boolean = false;
			var breakersToDelete:Array = new Array();
			//todo: kan alleen oppakken als in layer waarin geplaatst
			for (var i:int = 0; i < _wallbreakers.length; i++) {
				if (_wallbreakers.members[i].tileIndex == tileindex && _wallbreakers.members[i].layerId == level.currentLayer) {
					breakersToDelete.push(_wallbreakers.members[i]);
					//TODO: remove wallbreaker and fix walls
					for (var j:int = 0; j < _wallbreakers.members[i].breakLayers.length; j++) {
						level.layers[_wallbreakers.members[i].breakLayers[j]].setTileByIndex(_wallbreakers.members[i].breakTileIndex[j], _wallbreakers.members[i].breakTileType[j]);
					}
					_wallbreakers.members[i].kill();
					exists = true;
				} else if (_wallbreakers.members[i].tileIndex == tileindex) {
					exists = true;
				}
			}
			if (!exists) {
				var wallbreaker:WallBreaker = new WallBreaker(_player.x, _player.y, tileindex, level.currentLayer);	
				_wallbreakers.add(wallbreaker);
				
				for (var k:int = 0; k < level.layers.length; k++)
				{
					if (level.layers[k].getTileByIndex(tileindex) != 0) {
						//trace("layer " + i + " at " + tileindex + " of type " + level.layers[i].getTileByIndex(tileindex));
						wallbreaker.AddBreakPoint(k, tileindex, level.layers[k].getTileByIndex(tileindex));
						level.layers[k].setTileByIndex(tileindex, 0);
					}
				}
			}
			for (var l:int = 0; l < breakersToDelete.length; l++) {
				_wallbreakers.remove(breakersToDelete[l], true);
			}
		}
		
		private function NextLevel():void {
			level = new Level();
			level.LoadLevelData(LevelDataManager.getLevelData(_currentLevel));
			
			_wallbreakers = new FlxGroup();
			add(_wallbreakers);
			
			_player = new Player(level.spawn.x, level.spawn.y);
			add(_player);
		}
		
		private function CollidePlayerLevel(player:Player, level:FlxTilemap):void {
			player.HandleCollision();
		}
		private function OverlapPlayerSwitch(player:Player, object:Switch):void {
			//trace("switch LL:"+level.currentLayer+"CL" + object.currentLayer + "TL" + object.targetLayer + " touched:" + object.touched);
			//trace(player.x +", "+player.y)
			//trace(Math.floor( player.x) == object.x && Math.floor( player.y ) == Math.floor(object.y));
			if(level.currentLayer == object.currentLayer){
				if (!object.touched && Math.floor( player.x) == object.x && Math.floor( player.y ) == Math.floor(object.y)) {
					//trace("SWITCH LAYER")
					object.touched = true;
					level.SwitchToLayer(object.targetLayer);
					object.SwitchTarget();
					for (var i:int = 0; i < _wallbreakers.length; i++) {
						if (_wallbreakers.members[i].layerId == level.currentLayer) {
							_wallbreakers.members[i].alpha = 1;
						} else {
							_wallbreakers.members[i].alpha = 0.5;
						}
					}
				}else if (!(Math.floor( player.x) == object.x && Math.floor( player.y ) == Math.floor(object.y))) {
					//trace("TOUCH FALSE")
					object.touched = false;
				}
			}
		}
		private function OverlapPlayerPortal(player:Player, object:EndPortal):void {
			if (player.x % 64 == 0 && player.y % 64 == 0) {
				_wallbreakers.clear();
			
				level.kill();
				player.kill();
				_currentLevel++;
				NextLevel();
			}
		}
	}

}