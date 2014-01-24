package  
{
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class Player extends FlxSprite
	{
		[Embed(source = "../assets/TELEPORTER MAN Tiles.png")] private var ImgPlayer:Class;
		
		private const _maxSpeed:Point = new Point(10, 5);
		
		public function Player(X:int, Y:int):void 
		{
			super(X, Y);
			this.loadGraphic(ImgPlayer, false, false, 90, 10);
		}
		
		override public function update():void
		{
			if (FlxG.keys.LEFT)
			{
				this.x -= this._maxSpeed.x;
			}else if (FlxG.keys.RIGHT)
			{
				this.x += this._maxSpeed.x;
			}else if (FlxG.keys.UP)
			{
				this.y -= this._maxSpeed.y;
			}else if (FlxG.keys.DOWN)
			{
				this.y += this._maxSpeed.y;
			}
			
			super.update();
		}
		
	}

}