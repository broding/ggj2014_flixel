package
{
	import org.flixel.*;
	
	public class WallBreakerCount extends FlxGroup
	{
		private var _text:FlxText;
		private var _breakerSprite:FlxSprite;
		
		public function WallBreakerCount(MaxSize:uint=0)
		{
			super(MaxSize);
			
			_breakerSprite = new FlxSprite();
			_breakerSprite.makeGraphic(32, 32, 0xddffffff);
			_breakerSprite.x = FlxG.width / 2 - 16 - 13;
			_breakerSprite.y = 480;
			_breakerSprite.scrollFactor.make(0,0);
			
			_text = new FlxText(0, 0, FlxG.width, "              x 1");
			_text.y = 485;
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