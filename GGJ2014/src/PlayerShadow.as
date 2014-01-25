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
		private var _timeVisible:Number = 0.55; //time visible in seconds
		private var _timePassed:Number = 0;
		private var _parent:Player;
		private var myShape:Shape;
		private var _radius:Number = 25;
		
		public function PlayerShadow(X:int, Y:int, Parent:Player) 
		{
			X += 32;
			Y += 32;
			super(X, Y);
			
			_parent = Parent;
			myShape = new Shape();
		}
		
		override public function update():void
		{
			_timePassed += FlxG.elapsed;
			
			if (_timePassed >= _timeVisible)
			{
				this.kill();
				this.visible = false;
			}
			super.update();
		}
		
		override public function draw():void
		{
			var matrix:Matrix = new Matrix();
			matrix.translate( -FlxG.camera.scroll.x + this.x, -FlxG.camera.scroll.y + this.y);
			
			myShape.graphics.clear();
			myShape.graphics.beginFill(0xFFFFFF, lerp(0.5, 0, -(_timePassed / _timeVisible)));
			myShape.graphics.drawCircle(0 , 0, _radius);
			FlxG.camera.buffer.draw(myShape, matrix);
		}
		
		public function resetShadow(X:int, Y:int):void
		{
			this.x = X + 32;
			this.y = Y + 32;
			
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