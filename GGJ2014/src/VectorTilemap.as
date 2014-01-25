package
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;

	public class VectorTilemap extends FlxSprite
	{
		private var _shape:Shape;
		private var _crazyMatrix:Matrix;
		
		private var _timer:Number;
		private var _totalTime:Number;
		
		private var _startAlpha:Number = 0;
		private var _targetAlpha:Number = 0;
		
		public function VectorTilemap(tilemap:FlxTilemap, color:uint = 0xffffff, startAlpha:Number = 1, targetAlpha:Number = 0)
		{
			_startAlpha = startAlpha;
			_targetAlpha = targetAlpha;
			
			_timer = 0;
			_totalTime = 1;
			
			this.makeGraphic(FlxG.width, FlxG.height, 0x00fffff);
			
			this.width = width;
			this.height = height;
			
			_shape = new Shape();
			_shape.graphics.beginFill(color);
			
			for(var i:int = 0; i < tilemap.totalTiles; i++)
			{
				if(tilemap.getTileByIndex(i) != 0)
				{
					var point:FlxPoint = new FlxPoint((i % tilemap.widthInTiles) * 64, Math.floor(i / tilemap.widthInTiles) * 64);
					_shape.graphics.beginFill(0xffffff);
					_shape.graphics.drawRect(point.x, point.y, 64, 64);
					_shape.graphics.endFill();
				}
			}
			
			this.framePixels.draw(_shape);
			
			_crazyMatrix = new Matrix();
			_crazyMatrix.translate(-FlxG.camera.scroll.x, -FlxG.camera.scroll.y);
		}
		
		override public function update():void
		{
			super.update();
			
			_timer += FlxG.elapsed;
			
			if(_timer > _totalTime)
			{
				FlxG.state.remove(this);
			}
			
			setAlpha(lerp(_startAlpha, _targetAlpha, _timer / _totalTime));
		}
		
		override public function draw():void
		{	
			FlxG.camera.buffer.draw(framePixels, _crazyMatrix);
		}
		
		private function setAlpha(alpha:Number):void
		{
			var doubleBuffer:BitmapData = framePixels.clone();		
			framePixels.fillRect(framePixels.rect,0x00000000); 			
			var transform:ColorTransform = new ColorTransform(1.0, 1.0, 1.0, alpha);
			framePixels.draw(doubleBuffer,null,transform);						
			doubleBuffer.dispose();	
		}
		
		private function lerp(start:Number, end:Number, percent:Number):Number
		{
			return (start + percent * (end - start));
		}
	}
}