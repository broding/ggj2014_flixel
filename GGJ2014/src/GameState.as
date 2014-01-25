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
		private var tilemap:Level;
		private var _currentLevel:uint;
		
		private var _player:Player;
		
		public function GameState(selectedLevel:uint) 
		{
			super();
			
			_currentLevel = selectedLevel;
		}
		override public function create():void 
		{
			FlxG.visualDebug = true;
			tilemap = new Level();
			tilemap.LoadLevelData(LevelDataManager.getLevelData(_currentLevel));
			
			_player = new Player(tilemap.spawn.x, tilemap.spawn.y);
			add(_player);
			
			super.create();
		}
		
		override public function update():void 
		{
			FlxG.collide(_player, tilemap.layers[tilemap.currentLayer]);
			
			FlxG.overlap(_player, tilemap.switches, OverlapPlayerSwitch);
			FlxG.overlap(_player, tilemap.endPortal, OverlapPlayerPortal);
			super.update();
		}
		
		private function OverlapPlayerSwitch(player:Player, object:Switch):void {
			if (!object.touched && player.x % 64 == 0 && player.y % 64 == 0) {
				object.touched = true;
				tilemap.SwitchToLayer(object.targetLayer);
			}
		}
		private function OverlapPlayerPortal(player:Player, object:EndPortal):void {
			if (player.x % 64 == 0 && player.y % 64 == 0) {
				trace("D000NN33333");
				tilemap.kill();
			}
		}
	}

}