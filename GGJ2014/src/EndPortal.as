package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class EndPortal extends FlxSprite
	{
		[Embed(source = "../assets/finish.png")] private var _image:Class;
		public var touched:Boolean = false;
		public var targetLayer:int = 0;
		
		public function EndPortal(x:int, y:int, targetlayer:int = 0) 
		{
			super(x, y);
			this.width = this.height = GameState.tileSize;
			targetLayer = targetlayer;
			
			this.loadGraphic(_image, false, false, 64, 64);
			addAnimation("ding", [6], 0, false);
			play("ding");
		}
		
	}

}