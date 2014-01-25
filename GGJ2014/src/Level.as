package  
{
	
	import flash.system.System;
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	 
	public class Level extends FlxObject
	{	
		[Embed(source = '../assets/bg.png')]private var bgImage:Class;
		
		[Embed(source = '../assets/blue.png')]private var blue:Class;
		[Embed(source = '../assets/red.png')]private var red:Class;
		[Embed(source = '../assets/green.png')]private var green:Class;
		
		[Embed(source = '../assets/controls.png')]private var controls:Class;
		[Embed(source = '../assets/spacebar.png')]private var spacebar:Class;
		
		public var currentLayer:int = 0;
		public var spawn:FlxPoint = new FlxPoint(0, 0);
		public var layers:Array = new Array();
		public var switches:FlxGroup = new FlxGroup();
		public var endPortal:FlxSprite;
		public var worldBounds:Array = new Array();
		
		private var _rasterBackground:RasterBackground;
		private var _whiteBorder:WhiteBorder;
		private var _zoomBorder:ZoomBorder;
		
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
			bg.loadGraphic(bgImage);
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
							if (switches.members[s].currentLayer == this.currentLayer) {
								switches.members[s].visible = true;
							}else {
								switches.members[s].visible = false;
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
			
			FlxG.flash();
		
			width = layers[currentLayer].width;
			height = layers[currentLayer].height;
			
			_rasterBackground.widthInTiles = layers[currentLayer].widthInTiles;
			_rasterBackground.heightInTiles = layers[currentLayer].heightInTiles;
			
			_whiteBorder = new WhiteBorder(width, height);
			_zoomBorder = new ZoomBorder(width, height);
			
			bg.color = this.getLayerBackground(currentLayer);
			
			FlxG.state.add(_rasterBackground);
			FlxG.state.add(switches);
			
			FlxG.state.add(layers[currentLayer]);
			
			
			var worldTop:FlxSprite = new FlxSprite(-1, -1);
			worldTop.makeGraphic(width + 2, 1);
			worldTop.immovable = true;
			worldBounds.push(worldTop);
			var worldBot:FlxSprite = new FlxSprite(-1, height + 1);
			worldBot.makeGraphic(width + 2, 1);
			worldBot.immovable = true;
			worldBounds.push(worldBot);
			var worldLeft:FlxSprite = new FlxSprite(-1, -1);
			worldLeft.makeGraphic(1, height + 2);
			worldLeft.immovable = true;
			worldBounds.push(worldLeft);
			var worldRight:FlxSprite = new FlxSprite(width + 1, -1);
			worldRight.makeGraphic(1, height + 2);
			worldRight.immovable = true;
			worldBounds.push(worldRight);
			
			
			bg.x = width / 2 - FlxG.width / 2;
			bg.y = height / 2 - FlxG.height / 2;
			FlxG.state.add(_whiteBorder);
			//FlxG.state.add(_zoomBorder);
			
			if(lvlData.id == 1)
			{
				var controlHelp:FlxSprite = new FlxSprite(1 * 64, 1 * 64, controls);
				FlxG.state.add(controlHelp);
			}
			
			if(lvlData.id == 4)
			{
				var spacebarHelp:FlxSprite = new FlxSprite(3 * 64, 1 * 64, spacebar);
				FlxG.state.add(spacebarHelp);
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
		
		public function getLayerBackground(index:uint):uint
		{
			switch(index)
			{
				case 0:
					return 0x0000ff;
					break;
				case 1:
					return 0xff0000;
					break;
				case 2:
					return 0x00ff00;
					break;
			}
			
			return 0x0000ff;
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
				System.exit(0);
				return;
			}
			
			SyncSwitches();
			if (currentLayer > layer) {
			//	_zoomBorder.setFadeOut();
			}else {
			//	_zoomBorder.setFadeIn();
			}
			FlxG.state.remove(layers[currentLayer]);
			var oldLayer:int = currentLayer;
			currentLayer = layer;
			FlxG.state.add(layers[currentLayer]);
			SwitchesVisability();
			
			bg.color = this.getLayerBackground(currentLayer);
			_rasterBackground.shine();
			
			// show crazy tilinggggg
			var oldTileHighlighting:VectorTilemap = new VectorTilemap(layers[oldLayer], this.getLayerBackground(oldLayer));
			FlxG.state.add(oldTileHighlighting);
			
			var newTileHighlighting:VectorTilemap = new VectorTilemap(layers[currentLayer]);
			FlxG.state.add(newTileHighlighting);
		}
		
		private function SyncSwitches():void {
			for (var t:int = 0; t < switches.length; t++ ) {
				for (var s:int = 0; s < switches.length; s++ ) {
					if (switches.members[s].currentLayer == switches.members[t].targetLayer) {		
						//trace("[LEVEL] same loc: "+(Math.floor(switches.members[s].x) == Math.floor(switches.members[t].x) && Math.floor(switches.members[s].y) == Math.floor(switches.members[t].y)));
						//trace("[LEVEL] same s[ "+Math.floor(switches.members[s].x)+", "+Math.floor(switches.members[s].y)+"]t["+ Math.floor(switches.members[t].x)+","+Math.floor(switches.members[t].y)+"]");
						if (Math.floor(switches.members[s].x) == Math.floor(switches.members[t].x) && Math.floor(switches.members[s].y) == Math.floor(switches.members[t].y) ) {
							//trace("[LEVEL] SYNC s/t["+switches.members[s].touched+","+switches.members[t].touched+"]");
							switches.members[s].touched = switches.members[t].touched;
							//trace("[LEVEL]:"+switches.members[t].touched+"||"+switches.members[s].touched);
						}
					}
				}
			}
		}
		private function SwitchesVisability():void {
			for (var t:int = 0; t < switches.length; t++ ) {
				if (switches.members[t].currentLayer == this.currentLayer) {
					switches.members[t].visible = true;
				}else {
					switches.members[t].visible = false;
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