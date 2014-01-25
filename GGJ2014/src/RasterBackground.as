package
{
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	import org.flixel.*;
	import org.flixel.FlxSprite;

	public class RasterBackground extends FlxSprite
	{
		public var widthInTiles:uint = 0;
		public var heightInTiles:uint = 0;
		
		override public function draw():void
		{
			var matrix:Matrix = new Matrix();
			matrix.translate(-FlxG.camera.scroll.x, -FlxG.camera.scroll.y);
			
			var myShape:Shape = new Shape();
			myShape.graphics.lineStyle(1, 0xffffff, 0.2);
			
			for(var i:int = 0; i < widthInTiles; i++)
			{
				myShape.graphics.moveTo(i * GameState.tileSize, 0);
				myShape.graphics.lineTo(i * GameState.tileSize, heightInTiles * GameState.tileSize);
			}
			
			for(i = 0; i < heightInTiles; i++)
			{
				myShape.graphics.moveTo(0, i * GameState.tileSize);
				myShape.graphics.lineTo(widthInTiles * GameState.tileSize, i * GameState.tileSize);
			}
			
			FlxG.camera.buffer.draw(myShape, matrix);
		}
	}
}