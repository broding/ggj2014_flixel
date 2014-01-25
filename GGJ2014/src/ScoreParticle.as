package
{
	import org.flixel.FlxSprite;

	internal class ScoreParticle extends FlxSprite
	{
		override public function update():void
		{
			super.update();
			
			if(y > 308)
				kill();
		}
		
		override public function revive():void
		{
			super.revive();
			
			y = 259;
		}
	}
}