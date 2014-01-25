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
			
			super.create();
		}
		
		override public function update():void 
		{
			FlxG.collide(_player, level.layers[level.currentLayer]);
			
			FlxG.overlap(_player, level.switches, OverlapPlayerSwitch);
			FlxG.overlap(_player, level.endPortal, OverlapPlayerPortal);
			super.update();
		}
		
		private function NextLevel():void {
			level = new Level();
			level.LoadLevelData(LevelDataManager.getLevelData(_currentLevel));
			
			_player = new Player(level.spawn.x, level.spawn.y);
			add(_player);
		}
		
		private function OverlapPlayerSwitch(player:Player, object:Switch):void {
			if (!object.touched && player.x % 64 == 0 && player.y % 64 == 0) {
				object.touched = true;
				level.SwitchToLayer(object.targetLayer);
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