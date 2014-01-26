package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class WallBreaker extends FlxSprite
	{
		[Embed(source="../assets/wallbreaker.png")] private var ImgOverlay:Class;
		[Embed(source="../assets/wallbreaker_lightning.png")] private var ImgPlayer:Class;
		public var breakLayers:Array = new Array();
		public var breakTileIndex:Array = new Array();
		public var breakTileType:Array = new Array();
		public var tileIndex:int = 0;
		public var layerId:int = 0;
		public var overlay:FlxSprite;
		public function WallBreaker(xPos:int, yPos:int, tileindex:int = 0, layerid:int = 0) 
		{
			super(xPos, yPos);
			tileIndex = tileindex;
			layerId = layerid;
			this.loadGraphic(ImgPlayer, true, false, 64, 64);
			addAnimation("idle", [0, 1, 2, 3,4,5,6,7,8], 10);
			play("idle");
			
			overlay = new FlxSprite(this.x, this.y, ImgOverlay);
			overlay.visible = false;
		}
		
		public function AddBreakPoint(layer:int, tileindex:int, tiletype:int):void {
			breakLayers.push(layer);
			breakTileIndex.push(tileindex);
			breakTileType.push(tiletype);
		}
		public function colorize(checkColor:uint,replacementColor:uint):void {
			for (var jj:Number = 0; jj < this.pixels.height; jj++){
				for (var ii:Number = 0; ii < this.pixels.width; ii++) {
					//trace("color ["+ii+"]["+jj+"]: "+this.pixels.getPixel(ii, jj) );
					 if (this.pixels.getPixel(ii, jj) == checkColor) { //WHITE
						 
						 //trace("replace!");
						 this.pixels.setPixel(ii,jj,replacementColor);
					 }
				}
			}
		}
		override public function update():void 
		{
			super.update();
			if(overlay.visible){
				overlay.update();
			}
		}
		override public function draw():void 
		{
			super.draw();
			if(overlay.visible){
				overlay.draw();
			}
		}
	}

}