package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Stijn Groothuis
	 */
	
	public class SplashScreenState extends FlxState
	{
		
		[Embed(source = '../assets/Inverted_Splashscreen.png')]private var img1:Class;
		[Embed(source = '../assets/miniblue.png')]private var img2:Class;
		[Embed(source = '../assets/minigreen.png')]private var img3:Class;
		[Embed(source = '../assets/minired.png')]private var img4:Class;
		[Embed(source='../assets/logo.png')]private var img5:Class;
		private var splashscreen1:FlxSprite;
		private var splashscreen2:FlxSprite;
		private var splashscreen3:FlxSprite;
		private var splashscreen4:FlxSprite;
		private var selectSquare:WhiteBorder;
		
		private var timer:Number =0;
		private var timer1:Number =0;
		private var startTime:Boolean = true;
		private var moveblocks:Boolean = false;
		public function SplashScreenState() 
		{
			super();
		}
		override public function create():void 
		{
			splashscreen1 = new FlxSprite(0, 0, img1);
			add(splashscreen1);
			splashscreen1.visible = true;
			splashscreen1.x = (FlxG.width / 2) - (splashscreen1.width / 2);
			splashscreen1.y = (FlxG.height / 2) - (splashscreen1.height / 2);
			
			splashscreen3 = new FlxSprite(0, 0, img3);
			add(splashscreen3);
			splashscreen3.visible = false;
			splashscreen3.x = (FlxG.width / 2) - (splashscreen3.width / 2);
			splashscreen3.y = (FlxG.height / 2) - (splashscreen3.height / 2);
			
			splashscreen4 = new FlxSprite(0, 0, img4);
			add(splashscreen4);
			splashscreen4.visible = false;
			splashscreen4.x = (FlxG.width / 2) - (splashscreen4.width / 2)-20;
			splashscreen4.y = (FlxG.height / 2) - (splashscreen4.height / 2);
			
			splashscreen2 = new FlxSprite(0, 0, img2);
			add(splashscreen2);
			splashscreen2.visible = false;
			splashscreen2.x = (FlxG.width / 2) - (splashscreen2.width / 2)+ 20;
			splashscreen2.y = (FlxG.height / 2) - (splashscreen2.height / 2);
			
			splashscreen1.alpha = 0; 
			splashscreen2.alpha = 0; 
			
			
			super.create();
		}
		override public function update():void 
		{
			if(startTime){
				timer += FlxG.elapsed;
				
				if(splashscreen1.alpha<=1){
					splashscreen1.alpha += 0.05; 
				}
				if (timer >= 2) {
					
					startTime = false;
					timer = 0;
					
				}
			}else {
				if (splashscreen1.alpha>=0) {
					splashscreen1.alpha -= 0.05; 
				}
			}
			if (!startTime&&(splashscreen1.alpha<=0)) {
				if(!splashscreen2.visible){
					//FlxG.flash();
				}
				if(splashscreen2.alpha<=1){
					splashscreen2.alpha += 0.05; 
					splashscreen4.alpha = splashscreen3.alpha = splashscreen2.alpha;
				}
				if (splashscreen2.alpha >= 1) {
					if (splashscreen3.x == ((FlxG.width / 2) - (splashscreen2.width / 2))) {
						timer1 += FlxG.elapsed;
						if(timer1 >=0.3){
							moveblocks = true;
							timer1 = 0;
						}
					}
				}
				splashscreen1.visible = false;
				splashscreen2.visible = true;
				splashscreen3.visible = true;
				splashscreen4.visible = true;
				if ( moveblocks) {
					splashscreen2.x+=3.5;
					splashscreen4.x-=3.5;
				}
				if (splashscreen4.x <= ((FlxG.width / 2) - (splashscreen2.width / 2) - 210)) {
					moveblocks = false;
					timer+=FlxG.elapsed;
					
				}
				if (timer >= 0.5) {
					if(splashscreen2.visible&&splashscreen2.alive){
						FlxG.flash();
					}
					splashscreen1.visible = splashscreen2.visible = splashscreen3.visible = splashscreen4.visible = false;
					splashscreen1.kill(); splashscreen2.kill();splashscreen3.kill();splashscreen4.kill(); 
					FlxG.switchState(new MenuState());
				}
			}
			super.update();
		}
		
	}

}