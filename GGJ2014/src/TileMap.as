package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	 
	public class TileMap extends FlxObject
	{
		[Embed(source = '../assets/TELEPORTER MAN Tiles.png')]private var tiles_img:Class;
		private var layers:Array = new Array();
		
		public var currentLayer:FlxTilemap;
		
		public function TileMap(tilemaps:Array) 
		{
			if (tilemaps.length <= 0) {
				trace("empty layer array!");
				return;
			}
			
			for (var i:int = 0; i < tilemaps.length; i++) {
				layers.push(new FlxTilemap());
				FlxG.state.add(layers[i]);
				layers[i].loadMap(new tilemaps[i], tiles_img, GameState.tileSize, GameState.tileSize);
			}
			currentLayer = layers[i];
		}
		
		/*public function SwitchToLayer(layer:int) {
			currentLayer = layers[layer];
		}*/
	}
}