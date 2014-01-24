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
		[Embed(source = "../assets/lvl1/1.txt", mimeType = 'application/octet-stream')] private var ding1:Class;
		[Embed(source = "../assets/lvl1/2.txt", mimeType = 'application/octet-stream')] private var ding2:Class;
		
		public var currentLayer:int = 0;
		
		public var layers:Array = new Array();
		public var group1:FlxGroup = new FlxGroup();
		public function Level() 
		{
		}
		
		public function LoadLevelData(lvlData:LevelData):void {
			/*if (lvlData.layers.length <= 0) {
				trace("empty layer array!");
				return;
			}*/
				layers.push(new FlxTilemap());
				layers[0].loadMap(new ding1, tiles_img, GameState.tileSize, GameState.tileSize);
				layers.push(new FlxTilemap());
				layers[1].loadMap(new ding2, tiles_img, GameState.tileSize, GameState.tileSize);
			
			/*for (var i:int = 0; i < lvlData.layers.length; i++) {
				layers.push(new FlxTilemap());
				layers[i].loadMap(lvlData.layers[i], tiles_img, GameState.tileSize, GameState.tileSize);
			}*/
			
			for (var i:int = 0; i < layers[0].totalTiles; i++)
			{
				var t:int = layers[0].getTileByIndex(i);
				if (t == 4) {
					layers[0].setTileByIndex(i, 0);
					var switch1:Switch = new Switch(128, 0);
					FlxG.state.add(switch1);
					group1.add(switch1);
				}
			}
			for (var i2:int = 0; i2 < layers[1].totalTiles; i2++)
			{
				var t2:int = layers[1].getTileByIndex(i2);
				if (t2 == 4) {
					layers[1].setTileByIndex(i2, 0);
					var switch1:Switch = new Switch(128, 0);
					FlxG.state.add(switch1);
					group1.add(switch1);
				}
			}
			
			FlxG.state.add(layers[currentLayer]);
		}
		
		public function UnloadLevel():void {
			
		}
		
		public function SwitchToLayer(layer:int):void {
			if (layer < 0 && layer >= layers.length) {
				trace("this layer does not exist");
				return;
			}
			FlxG.state.remove(layers[currentLayer]);
			currentLayer = layer;
			FlxG.state.add(layers[currentLayer]);
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