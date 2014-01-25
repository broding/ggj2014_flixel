package  
{
	import flash.display.InteractiveObject;
	import org.flixel.FlxSprite;
	import org.flixel.*;
	import flash.geom.Matrix;
	import flash.display.Shape;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class PlayerShadow extends FlxSprite
	{
		[Embed(source="../assets/player.png")] private var ImgPlayer:Class;
		
		private var _timeVisible:Number = 0.19; //time visible in seconds
		private var _timePassed:Number = 0;
		private var _parent:Player;
		private var myShape:Shape;
		private var _radius:Number = 2;
		
		public function PlayerShadow(X:int, Y:int, Parent:Player) 
		{
			super(X, Y);
			
			loadGraphic(ImgPlayer);
			
			_parent = Parent;
			myShape = new Shape();
			
		}
		
		override public function update():void
		{
			_timePassed += FlxG.elapsed;
			
			this.alpha = lerp(0.5, 0, -(_timePassed / _timeVisible));
			
			if (_timePassed >= _timeVisible)
			{
				this.kill();
				this.visible = false;
			}
			super.update();
		}
		
		public function resetShadow(X:int, Y:int):void
		{
			this.x = X;
			this.y = Y;
			
			this._timePassed = 0;
			this.revive();
			this.visible = true;
		}
		
		private function lerp(start:Number, end:Number, percentage:Number):Number
		{
			if (start == end) return start;
			
			return (start + percentage * (start - end));
		}
		
	}

}