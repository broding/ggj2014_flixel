package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class Switch extends FlxSprite
	{
		[Embed(source = "../assets/TELEPORTER MAN Tiles.png")] private var ImgPlayer:Class;
		public var touched:Boolean = false;
		public var targetLayer:int = 0;
		
		public function Switch(x:int, y:int, targetlayer:int = 0) 
		{
			super(x, y);
			this.width = this.height = GameState.tileSize;
			targetLayer = targetlayer;
			
			this.loadGraphic(ImgPlayer, false, false, 64, 64);
			addAnimation("ding", [5], 0, false);
			play("ding");
		}
	}

}