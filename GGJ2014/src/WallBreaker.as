package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class WallBreaker extends FlxSprite
	{
		[Embed(source="../assets/wallbreaker.png")] private var ImgPlayer:Class;
		public var breakLayers:Array = new Array();
		public var breakTileIndex:Array = new Array();
		public var breakTileType:Array = new Array();
		public var tileIndex:int = 0;
		public var layerId:int = 0;
		
		public function WallBreaker(xPos:int, yPos:int, tileindex:int = 0, layerid:int = 0) 
		{
			super(xPos, yPos);
			tileIndex = tileindex;
			layerId = layerid;
			this.loadGraphic(ImgPlayer, false, false, 64, 64);
		}
		
		public function AddBreakPoint(layer:int, tileindex:int, tiletype:int):void {
			breakLayers.push(layer);
			breakTileIndex.push(tileindex);
			breakTileType.push(tiletype);
		}
	}

}