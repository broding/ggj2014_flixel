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
		public var _fadeout:Boolean = false;
		public var _fadein:Boolean = false;
		public function ZoomBorder(width:int,height:int, x:int, y:int) 
		{
			super(width, height, x, y);
			
		}
		override public function draw():void 
		{
			super.draw();
			matrix.scale(zoom, zoom);
			matrix.translate( ((-FlxG.camera.scroll.x - (GLOW_MARGIN))*2)-(matrix.tx*2), ((-FlxG.camera.scroll.y - (GLOW_MARGIN))*2)-(matrix.ty*2));
			//matrix.translate(-(matrix.tx), -(matrix.tx));
			
			FlxG.camera.buffer.draw(framePixels, matrix);
			if (_fadein) {
				if(zoom > 1){
					zoom -= 1;
				}else {
					_fadein = false;
				}
			}
			if (_fadeout) {
				if(zoom<=5){
					zoom += 1;
				}else {
					_fadeout = false;
				}
			}
			
		}
		public function setFadeOut():void {
			zoom = 1;
			_fadeout = true;
		}
		public function setFadeIn():void {
			zoom = 5;
			_fadein = true;
		}
		
	}

}