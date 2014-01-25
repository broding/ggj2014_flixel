package
{
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	import org.flixel.*;
	import org.flixel.FlxSprite;

	public class WhiteBorder extends FlxSprite
	{
		public function WhiteBorder()
		{
		}
		
		override public function draw():void
		{
			var matrix:Matrix = new Matrix();
			matrix.translate(-FlxG.camera.scroll.x, -FlxG.camera.scroll.y);
			
			var myShape:Shape = new Shape();
			myShape.graphics.lineStyle(1, 0xffffff);
			myShape.graphics.drawRect(0,0,width,height);
			FlxG.camera.buffer.draw(myShape, matrix);
		}
	}
}