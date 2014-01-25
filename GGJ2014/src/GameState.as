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
		
		public function GameState(selectedLevel:uint) 
		{
			super();
			
			_currentLevel = selectedLevel;
		}
		override public function create():void 
		{	
			level = new Level();
			level.LoadLevelData(LevelDataManager.getLevelData(_currentLevel));
			
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
			
			if (FlxG.keys.A && !_player.moving) {
				var index:int = Math.floor(_player.x / 64) + (Math.floor(_player.y / 64) * level.layers[level.currentLayer].widthInTiles);
				level.layers[level.currentLayer].setTileByIndex(index, 1);
			}
			super.update();
		}
		
		private function NextLevel():void {
			level = new Level();
			level.LoadLevelData(LevelDataManager.getLevelData(_currentLevel));
			
			_player = new Player(level.spawn.x, level.spawn.y);
			add(_player);
		}
		
		private function CollidePlayerLevel(player:Player, level:FlxTilemap):void {
			player.HandleCreation();
		}
		private function OverlapPlayerSwitch(player:Player, object:Switch):void {
			trace("switch CL" + object.currentLayer + "TL" + object.targetLayer + " touched:" + object.touched);
			trace(player.x +", "+player.y)
			trace((player.x % 64 == 0 && player.y % 64 == 0));
			if (!object.touched && player.x % 64 == 0 && player.y % 64 == 0) {
				level.SwitchToLayer(object.targetLayer);
				if(!object.touched){
					if (object.targetLayer==object.layer_2) {
						object.currentLayer = object.layer_2;
						object.targetLayer = object.layer_1;
					}else if (object.targetLayer==object.layer_1) {
						object.currentLayer = object.layer_1;
						object.targetLayer = object.layer_2;
					}
				}
				object.touched = true;
			}else if(!(player.x % 64 == 0 && player.y % 64 == 0)){
				object.touched = false;
			}
		}
		private function OverlapPlayerPortal(player:Player, object:EndPortal):void {
			if (player.x % 64 == 0 && player.y % 64 == 0) {
				level.kill();
				player.kill();
				_currentLevel++;
				NextLevel();
			}
		}
	}

}