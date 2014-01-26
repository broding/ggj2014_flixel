package
{
	import flash.display.Shape;
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		[Embed(source = "../assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF = "false", mimeType = "application/x-font")]
		private var FontClass2:Class;
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
		
		private var titlescreen:FlxSprite;
		private var menutext:FlxText;
		private var timer:Number =0;
		private var startTime:Boolean = true;
		private var moveblocks:Boolean = true;
		private var controls_on:Boolean = false;
		
		private var selected:int = 0;
		
		private var goUp:Boolean = false;
		private var goDown:Boolean = false;
		
		public function MenuState()
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
			splashscreen4.x = (FlxG.width / 2) - (splashscreen4.width / 2);
			splashscreen4.y = (FlxG.height / 2) - (splashscreen4.height / 2);
			
			splashscreen2 = new FlxSprite(0, 0, img2);
			add(splashscreen2);
			splashscreen2.visible = false;
			splashscreen2.x = (FlxG.width / 2) - (splashscreen2.width / 2);
			splashscreen2.y = (FlxG.height / 2) - (splashscreen2.height / 2);
			
			titlescreen = new FlxSprite(0, 0, img5);
			add(titlescreen);
			titlescreen.visible = false;
			titlescreen.width = 100;
			titlescreen.height = 100;
			titlescreen.x = 0;// (FlxG.width / 2) - (splashscreen2.width / 2);
			titlescreen.y = 0;// (FlxG.height / 2) - (splashscreen2.height / 2);
			
			splashscreen1.alpha = 0; 
			splashscreen2.alpha = 0; 
			
			menutext = new FlxText(0, 0, 300, "PLAY\n\nCredits");
			menutext.setFormat("AldotheApache", 30);
			menutext.alignment = "center";
			menutext.x = (FlxG.width/2)-150;
			menutext.y = 400;
			add(menutext);
			menutext.visible = false;
			
			selectSquare = new WhiteBorder(200, 35, (FlxG.width / 2) - (200 / 2), menutext.y);
			selectSquare.visible = false;
			add(selectSquare);
			
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
				}
				if (splashscreen2.alpha >= 1) {
					splashscreen3.visible = true;
					splashscreen4.visible = true;
					if(splashscreen2.x ==((FlxG.width / 2) - (splashscreen2.width / 2))){
						moveblocks = true;
					}
				}
				splashscreen1.visible = false;
				splashscreen2.visible = true;
				if ( moveblocks) {
					splashscreen2.x--;
					splashscreen4.x++;
				}
				if (splashscreen2.x <= ((FlxG.width / 2) - (splashscreen2.width / 2) - 50)) {
					moveblocks = false;
					timer+=FlxG.elapsed;
					
				}
				if (timer >= 0.6) {
					if(splashscreen2.visible&&splashscreen2.alive){
						FlxG.flash();
					}
					splashscreen1.visible = splashscreen2.visible = splashscreen3.visible = splashscreen4.visible = false;
					splashscreen1.kill(); splashscreen2.kill();splashscreen3.kill();splashscreen4.kill(); 
					showTitle();
				}
				if (controls_on) {
					if(selected!=1){
						if (FlxG.keys.justPressed("DOWN")) {
							selectSquare.y = (menutext.y + menutext.height - selectSquare.height) - 5;
							selected = 1;
						}
					}
					if(selected!=0){
						if (FlxG.keys.justPressed("UP")) {
							selectSquare.y = (menutext.y+3)
							selected = 0;
						}
					}
					if (FlxG.keys.justPressed("SPACE")) {
							if (selected == 0) {
								FlxG.switchState(new LevelState());
							}else if (selected == 1) {
								FlxG.switchState(new HighscoreState());
							}
						}
				}
			}
			
			super.update();
		}
		public function showTitle():void {
			menutext.visible = true;
			titlescreen.visible = true;
			controls_on = true;
			selectSquare.visible = true;
		}
	}
}