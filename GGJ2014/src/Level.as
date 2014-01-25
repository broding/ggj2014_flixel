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
		[Embed(source = "../assets/levels/1/1.txt", mimeType = 'application/octet-stream')] private var ding1:Class;
		[Embed(source = "../assets/levels/1/2.txt", mimeType = 'application/octet-stream')] private var ding2:Class;
		
		public var currentLayer:int = 0;
		public var spawn:FlxPoint = new FlxPoint(0, 0);
		public var layers:Array = new Array();
		public var switches:FlxGroup = new FlxGroup();
		public var endPortal:FlxSprite;
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
				
				for (var j:int = 0; j < layers[i].totalTiles; j++)
				{
					var xPos:int = j % layers[i].widthInTiles * GameState.tileSize;
					var yPos:int = (int)(j / layers[i].widthInTiles) * GameState.tileSize;
					
					var t:int = layers[i].getTileByIndex(j);
					if (t == 2) {
						layers[i].setTileByIndex(j, 0);
						spawn = new FlxPoint(xPos, yPos);
					}
					if (t == 3) {
						layers[i].setTileByIndex(j, 0);
						if (endPortal == null) {
							endPortal = new EndPortal(xPos, yPos, 1);
							FlxG.state.add(endPortal);
						}
					}
					if (t == 4) {
						layers[i].setTileByIndex(j, 0);
						var switch1:Switch = new Switch(xPos, yPos,lvlData.id,lvlData.id + 1);
						switches.add(switch1);
					}
				}
			}
			FlxG.state.add(switches);
			
			FlxG.state.add(layers[currentLayer]);
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
			switches.clear();
			endPortal.kill();
			for (var i:int = 0; i < layers.length; i++) {
				layers[i].kill();
			}
			super.kill();
		}
	}
}