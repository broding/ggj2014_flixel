package
{
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		[Embed(source = '../assets/Inverted_Splashscreen.png')]private var img1:Class;
		[Embed(source='../assets/miniblue.png')]private var img2:Class;
		private var splashscreen1:FlxSprite;
		private var splashscreen2:FlxSprite;
		private var timer:Number =0;
		private var startTime:Boolean = false;
		
		public function MenuState()
		{
			super();
		}
		override public function create():void 
		{
			splashscreen1 = new FlxSprite(0, 0, img1);
			add(splashscreen1);
			splashscreen1.visible = true;
			splashscreen2 = new FlxSprite(0, 0, img2);
			add(splashscreen2);
			splashscreen2.visible = false;
			FlxG.flash(0xffFF0000, 1, function():void { startTime =true} );
			
			super.create();
		}
		override public function update():void 
		{
			trace(startTime+"|"+timer);
			if(startTime){
				timer += FlxG.elapsed;
				if (timer >= 2) {
					startTime = false;
					timer = 0;
					FlxG.fade(0xffFF0000, 1, function():void { 
					splashscreen1.visible = false; showTitle(); FlxG.flash(0xffFFFF00); } );
					FlxG
				}
			}
			super.update();
		}
		public function showTitle():void {
			splashscreen1.visible = true;
		}
	}
}