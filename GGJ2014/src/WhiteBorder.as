package
{
	import flash.display.Shape;
	import org.flixel.*;
	
	import org.flixel.FlxSprite;

	public class WhiteBorder extends FlxSprite
	{
		public function WhiteBorder()
		{
		}
		
		override public function draw():void
		{
			super.draw();
			
			var myShape:Shape = new Shape();
			myShape.graphics.lineStyle(1);
			myShape.graphics.drawCircle();
			FlxG.camera.buffer.draw(myShape);
		}
	}
}