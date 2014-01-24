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
		
		public function Switch(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			this.width = this.height = GameState.tileSize;
			
			this.loadGraphic(ImgPlayer, false, false, 64, 64);
			addAnimation("ding", [4], 0, false);
			play("ding");
		}
	}

}