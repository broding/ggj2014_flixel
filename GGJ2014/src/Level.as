package  
{
	import org.flixel.*;
	import LevelData;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	 
	public class Level extends FlxObject
	{
		[Embed(source = '../assets/TELEPORTER MAN Tiles.png')]private var tiles_img:Class;
		private var layers:Array = new Array();
		
		public var currentLayer:FlxTilemap;
		
		public function Level() 
		{
		}
		
		public function LoadLevelData(lvlData:LevelData):void {
			if (lvlData.layers.length <= 0) {
				trace("empty layer array!");
				return;
			}
			
			for (var i:int = 0; i < lvlData.layers.length; i++) {
				layers.push(new FlxTilemap());
				layers[i].loadMap(lvlData.layers[i], tiles_img, GameState.tileSize, GameState.tileSize);
			}
			currentLayer = layers[0];
			FlxG.state.add(currentLayer);
		}
		
		public function UnloadLevel():void {
			
		}
		
		public function SwitchToLayer(layer:int):void {
			if (layer < 0 && layer >= layers.length) {
				trace("this layer does not exist");
				return;
			}
			currentLayer = layers[layer];
		}
		
		override public function kill():void 
		{
			for (var i:int = 0; i < layers.length; i++) {
				layers[i].kill();
			}
			super.kill();
		}
	}
}