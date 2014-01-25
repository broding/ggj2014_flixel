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
		
		private var _shining:Boolean = false;
		private var _alphaTimer:Number = 0;
		private var _alphaMax:Number = 0.4;
		
		public function RasterBackground()
		{
			_alpha = 0.2;
		}
		
		public function shine():void
		{
			_shining = true;
			_alpha = 0.7
		}
		
		override public function update():void
		{
			if(_shining)
			{
				_alphaTimer += FlxG.elapsed;
				
				if(_alphaTimer < _alphaMax / 2)
					_alpha = lerp(0.7, 1, _alphaTimer / (_alphaMax / 2));
				else
					_alpha = lerp(1, 0.2, _alphaTimer / _alphaMax);
				
				if(_alphaTimer > _alphaMax)
				{
					_alphaTimer = 0;
					_alpha = 0.2;
					_shining = false;
				}
				
			}
		}
		
		private function lerp(start:Number, end:Number, percent:Number):Number
		{
			return (start + percent * (end - start));
		}
		
		override public function draw():void
		{
			var matrix:Matrix = new Matrix();
			matrix.translate(-FlxG.camera.scroll.x, -FlxG.camera.scroll.y);
			
			var myShape:Shape = new Shape();
			myShape.graphics.lineStyle(1, 0xffffff, _alpha);
			
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