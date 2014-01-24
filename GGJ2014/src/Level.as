package  
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class Level extends FlxObject
	{
		private var tilemap:TileMap;
		private var tilemaps:Array;
		public function Level() 
		{
			tilemaps = new Array();
		}
		public function LoadLevel():void {
			tilemap = new TileMap(tilemaps);
		}
		public function UnloadLevel():void {
			tilemap.kill();
		}
	}

}