package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class WallBreaker extends FlxSprite
	{
		[Embed(source="../assets/eyeball player.png")] private var ImgPlayer:Class;
		private var breakLayers:Array = new Array();
		private var breakTileIndex:Array = new Array();
		private var breakTileType:Array = new Array();
		
		public function WallBreaker(xPos:int, yPos:int) 
		{
			super(xPos, yPos);
			this.loadGraphic(ImgPlayer, false, false, 64, 64);
		}
		
		public function AddBreakPoint(layer:int, tileindex:int, tiletype:int):void {
			breakLayers.push(layer);
			breakTileIndex.push(tileindex);
			breakTileType.push(tiletype);
			
			RemoveDuplicates(breakLayers);
			RemoveDuplicates(breakTileIndex);
			RemoveDuplicates(breakTileType);
		}
		
		private function RemoveDuplicates(list:Array):void {
			var i:int = 0;
			while(i < list.length) {
				while(i < list.length+1 && list[i] == list[i+1]) {
					list.splice(i, 1);
				}
				i++;
			}
		}
	}

}