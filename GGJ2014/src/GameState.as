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
		private var tilemap:TileMap;
		
		private var _player:Player;
		
		public function GameState() 
		{
			super();
		}
		override public function create():void 
		{
			tilemap = new TileMap([lvl_1]);
			
			_player = new Player(200, 200);
			add(_player);
			super.create();
		}
		
	}

}