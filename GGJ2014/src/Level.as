package  
{
	
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	 
	public class Level extends FlxObject
	{	
		[Embed(source = '../assets/blue.png')]private var blue:Class;
		[Embed(source = '../assets/red.png')]private var red:Class;
		[Embed(source = '../assets/green.png')]private var green:Class;
		[Embed(source = '../assets/TELEPORTER MAN Tiles.png')]private var tiles_img:Class;
		
		[Embed(source = '../assets/controls.png')]private var controls:Class;
		
		public var currentLayer:int = 0;
		public var spawn:FlxPoint = new FlxPoint(0, 0);
		public var layers:Array = new Array();
		public var switches:FlxGroup = new FlxGroup();
		public var endPortal:FlxSprite;
		
		private var _rasterBackground:RasterBackground;
		private var _whiteBorder:WhiteBorder;
		private var _zoomBorder:WhiteBorder;
		
		private var bg:FlxSprite;
		
		public function Level() 
		{
			_whiteBorder = new WhiteBorder(width, height);
			_zoomBorder = new ZoomBorder(width, height);
			_rasterBackground = new RasterBackground();
		}
		
		public function LoadLevelData(lvlData:LevelData):void {
			if (lvlData.layers.length <= 0) {
				trace("empty layer array!");
				return;
			}
			
			bg = new FlxSprite();
			bg.makeGraphic(800, 600, 0xff000055);
			FlxG.state.add(bg);
			
			for (var i:int = 0; i < lvlData.layers.length; i++) {
				layers.push(new FlxTilemap());
				layers[i].loadMap(lvlData.layers[i], this.getLayerColor(i), GameState.tileSize, GameState.tileSize);
				
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
					if (t == 4 || t== 5 || t == 6 || t == 7) {
						layers[i].setTileByIndex(j, 0);
						
						var nextlayer:int = 1;
						
						if (t == 5)
							nextlayer = -1;
						else if(t == 6) 
							nextlayer = 2
						else if(t == 7) 
							nextlayer = -2;
						
						var switch1:Switch = new Switch(xPos, yPos, (i), (i) + nextlayer);
						switches.add(switch1);
						
						for (var s:int = 0; s < switches.length; s++ ) {
							if (switches.members[s].currentLayer == i + nextlayer) {
								if (Math.floor(switches.members[s].x) == Math.floor(xPos) && Math.floor(switches.members[s].y) == Math.floor(yPos) ) {
									switch1.touching = switches.members[s].touching;
								}
							}
						}
					}
					
					
				}
				
				for (var k:int = 0; k < layers[i].totalTiles; k++)
				{
					if((layers[i] as FlxTilemap).getTileByIndex(k) != 0)
						(layers[i] as FlxTilemap).setTileByIndex(k, getAutoTileValue(i, k));
				}
			}
		
			width = layers[currentLayer].width;
			height = layers[currentLayer].height;
			
			_rasterBackground.widthInTiles = layers[currentLayer].widthInTiles;
			_rasterBackground.heightInTiles = layers[currentLayer].heightInTiles;
			
			_whiteBorder = new WhiteBorder(width, height);
			_zoomBorder = new ZoomBorder(width, height);
			
			FlxG.state.add(_rasterBackground);
			FlxG.state.add(switches);
			
			FlxG.state.add(layers[currentLayer]);
			
			
			bg.x = width / 2 - FlxG.width / 2;
			bg.y = height / 2 - FlxG.height / 2;
			FlxG.state.add(_whiteBorder);
			//FlxG.state.add(_zoomBorder);
			
			if(lvlData.id == 1)
			{
				var controlHelp:FlxSprite = new FlxSprite(1 * 64, 1 * 64, controls);
				FlxG.state.add(controlHelp);
			}
		}
		
		private function getLayerColor(index:uint):Class
		{
			switch(index)
			{
				case 0:
					return blue;
					break;
				case 1:
					return red;
					break;
				case 2:
					return green;
					break;
			}
			
			return blue;
		}
		
		private function getLayerBackground(index:uint):uint
		{
			switch(index)
			{
				case 0:
					return 0xff000055
					break;
				case 1:
					return 0xff550000;
					break;
				case 2:
					return 0xff005500;
					break;
			}
			
			return 0xff000055;
		}
		
		private function getAutoTileValue(layerIndex:uint, tileIndex:uint):uint
		{
			var point:FlxPoint = new FlxPoint(tileIndex % layers[layerIndex].widthInTiles, Math.floor(tileIndex / layers[layerIndex].widthInTiles));
			
			var tilemap:FlxTilemap = layers[layerIndex];
			
			var autotile:uint = 0;
			
			if(tilemap.getTile(point.x, point.y - 1)) autotile += 1;
			if(tilemap.getTile(point.x + 1, point.y)) autotile += 2;
			if(tilemap.getTile(point.x, point.y + 1)) autotile += 4;
			if(tilemap.getTile(point.x - 1, point.y)) autotile += 8;
			
			return autotile;
		}
		
		public function SwitchToLayer(layer:int):void {
			if (layer < 0 && layer >= layers.length) {
				trace("this layer does not exist");
				return;
			}
			
			SyncSwitches();
			FlxG.state.remove(layers[currentLayer]);
			currentLayer = layer;
			FlxG.state.add(layers[currentLayer]);
			
			bg.makeGraphic(900, 700, this.getLayerBackground(currentLayer));
			_rasterBackground.shine();
		}
		private function SyncSwitches():void {
			for (var t:int = 0; t < switches.members.length; t++ ) {
				for (var s:int = 0; s < switches.members.length; s++ ) {
					if (switches.members[s].currentLayer == switches.members[t].targetLayer) {		
						trace("[LEVEL] same loc: "+(Math.floor(switches.members[s].x) == Math.floor(switches.members[t].x) && Math.floor(switches.members[s].y) == Math.floor(switches.members[t].y)));
						trace("[LEVEL] same s[ "+Math.floor(switches.members[s].x)+", "+Math.floor(switches.members[s].y)+"]t["+ Math.floor(switches.members[t].x)+","+Math.floor(switches.members[t].y)+"]");
						if (Math.floor(switches.members[s].x) == Math.floor(switches.members[t].x) && Math.floor(switches.members[s].y) == Math.floor(switches.members[t].y) ) {
							trace("[LEVEL] SYNC s/t["+switches.members[s].touched+","+switches.members[t].touched+"]");
							switches.members[s].touched = switches.members[t].touched;
							trace("[LEVEL]:"+switches.members[t].touched+"||"+switches.members[s].touched);
						}
					}
				}
			}
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