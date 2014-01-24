package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	 
	public class TileMap 
	{
		private var layers:Array = new Array();
		private var colorCount:int;
		private var currentLayer:TileMap;
		
		public function TileMap(tilemaps:Array) 
		{
			if (tilemaps.length <= 0) {
				trace("empty tilemap array!");
				return;
			}
			for (var i:int = 0; i < tilemaps.length; i++) {
				layers.push(new TileMap());
				//layers[i].loadMap()
			}
			currentLayer = tilemaps[0];
		}
		
		public function SwitchToLayer(layer:int) {
			currentLayer = layers[layer];
		}
	}
}