package
{
	import flash.display.Shape;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flixel.*;

	public class WhiteBorder extends FlxSprite
	{
		protected const GLOW_MARGIN:int = 20;
		protected var matrix:Matrix;
		public function WhiteBorder(width:int, height:int)
		{
			this.makeGraphic(width + 1 + GLOW_MARGIN * 2, height + 1 + GLOW_MARGIN * 2, 0x00fffff);
			
			this.width = width;
			this.height = height;
			
			var myShape:Shape = new Shape();
			myShape.graphics.lineStyle(1, 0xffffff);
			myShape.graphics.drawRect(GLOW_MARGIN, GLOW_MARGIN, width, height);
			
			
			this.framePixels.draw(myShape);
			
			framePixels.applyFilter(framePixels, framePixels.rect, new Point(0,0), new GlowFilter(0xffffff, 1, 10, 10,3, 2));
			matrix = new Matrix();
		}
		
		override public function draw():void
		{	
			matrix.identity();
			matrix.translate(-FlxG.camera.scroll.x - GLOW_MARGIN, -FlxG.camera.scroll.y - GLOW_MARGIN);
			
			FlxG.camera.buffer.draw(framePixels, matrix);
		}
	}
}