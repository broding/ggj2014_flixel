package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class Switch extends FlxSprite
	{
		[Embed(source = "../assets/TELEPORTER MAN Tiles.png")] private var player:Class;
		[Embed(source = "../assets/switch.png")] private var _image:Class;
		public var touched:Boolean = false;
		public var targetLayer:int = 0;
		public var currentLayer:int = 0;
		public var layer_1:int;
		public var layer_2:int;
		
		
		public function Switch(x:int, y:int, currentlayer:int = 0, targetlayer:int = 0) 
		{
			super(x, y);
			this.width = this.height = GameState.tileSize;
			layer_1 = currentlayer;
			layer_2 = targetlayer;
			currentLayer = currentlayer;
			targetLayer = targetlayer;
			
			this.loadGraphic(_image, false, false, 64, 64);
			addAnimation("ding", [5], 0, false);
			play("ding");
		}
		public function SwitchTarget():void {
			var tmplayer:int = currentLayer;
			currentLayer = targetLayer;
			targetLayer = tmplayer;
		}
	}

}