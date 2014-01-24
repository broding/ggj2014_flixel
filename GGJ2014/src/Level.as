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
			FlxG.state.add(tilemap);
		}
		public function KillLevel():void {
			tilemap.kill();
		}
	}

}