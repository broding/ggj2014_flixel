package
{
	import flash.display.Shape;
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		[Embed(source='../assets/Music/menuMove.mp3')]private var selectsnd:Class;
		[Embed(source = "../assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF = "false", mimeType = "application/x-font")]
		private var FontClass2:Class;
		[Embed(source = "../assets/Music/MenuSongFinished.mp3")] private var _backgroundMusic:Class;
		[Embed(source = '../assets/logo.png')]private var img5:Class;
		
		private var selectSquare:WhiteBorder;
		
		private var titlescreen:FlxSprite;
		private var menutext:FlxText;
		private var moveblocks:Boolean = false;
		private var controls_on:Boolean = true;
		
		private var selected:int = 0;
		
		private var goUp:Boolean = false;
		private var goDown:Boolean = false;
		
		public function MenuState()
		{
			FlxG.playMusic(_backgroundMusic, 0.5);
			super();
		}
		override public function create():void 
		{
			FlxG.flash();
			titlescreen = new FlxSprite(0, 0, img5);
			add(titlescreen);
			titlescreen.visible = true;
			titlescreen.width = 100;
			titlescreen.height = 100;
			titlescreen.x = 0;// (FlxG.width / 2) - (splashscreen2.width / 2);
			titlescreen.y = 0;// (FlxG.height / 2) - (splashscreen2.height / 2);
			
			
			menutext = new FlxText(0, 0, 300, "PLAY\nCredits\nHighscore");
			menutext.setFormat("AldotheApache", 30);
			menutext.alignment = "center";
			menutext.x = (FlxG.width/2)-150;
			menutext.y = 400;
			add(menutext);
			menutext.visible = true;
			
			selectSquare = new WhiteBorder(200, 35, (FlxG.width / 2) - (200 / 2), menutext.y);
			selectSquare.visible = true;
			add(selectSquare);
			
			super.create();
		}
		override public function update():void 
		{
			if (controls_on) {
				if(selected!=2){
					if (FlxG.keys.justPressed("DOWN")) {
						FlxG.play(selectsnd, 0.5);
						selectSquare.y += selectSquare.height+3;
						selected++;
					}
				}
				if(selected!=0){
					if (FlxG.keys.justPressed("UP")) {
						FlxG.play(selectsnd, 0.5);
						selectSquare.y -= selectSquare.height+3;
						selected --;
					}
				}
				if (FlxG.keys.justPressed("SPACE")) {
					if (selected == 0) {
						FlxG.switchState(new LevelState());
					}else if (selected == 1) {
						FlxG.switchState(new CreditState());
					}else if (selected == 2) {
								FlxG.switchState(new HighscoreState());
					}
				}
			}
			
			
			super.update();
		}
	}
}