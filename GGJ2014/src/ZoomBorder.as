package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Stijn Groothuis
	 */
	public class ZoomBorder extends WhiteBorder
	{
		public var fadeout:Boolean = false;
		public var fadein:Boolean = false;
		public var zoom:Number = 1;
		public function ZoomBorder(width:int,height:int) 
		{
			super(width, height);
			this.x = FlxG.width - this.width;
			this.y = FlxG.height - this.height;
		}
		override public function draw():void 
		{
			matrix.translate(( -((this.width * zoom) - this.width) / 2), -((this.height * zoom) - this.height) / 2);
			
			matrix.scale(zoom, zoom);
			FlxG.camera.buffer.draw(framePixels, matrix);
			zoom += 0.00001;
			
		}
		
	}

}