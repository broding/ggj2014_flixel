package
{
	import org.flixel.*;
	
	public class WallBreakerCount extends FlxGroup
	{
		private var _text:FlxText;
		private var _breakerSprite:WallBreaker;
		private var _y:int;
		
		public function WallBreakerCount(y:int)
		{
			super(0);
			
			_y = FlxG.height / 2 + y / 2 + 7;
			
			_breakerSprite = new WallBreaker(FlxG.width / 2 - 16 - 35, _y - 10, 0, 0);
			_breakerSprite.scrollFactor.make(0,0);
			_breakerSprite.active = false;
			_breakerSprite.frame = 4;
			
			_text = new FlxText(0, 0, FlxG.width, "              x 1");
			_text.y = _y + 5;
			_text.scrollFactor.make(0,0);
			_text.setFormat("AldotheApache", 15, 0xeeeeee);
			_text.alignment = "center";
			
			add(_text);
			add(_breakerSprite);
		}
		
		public function updateAmount(amount:uint):void
		{
			_text.text = "              x " + amount;
		}
	}
}