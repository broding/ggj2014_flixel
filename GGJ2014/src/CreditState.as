package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class CreditState extends FlxState
	{
		[Embed(source = "../assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF = "false", mimeType = "application/x-font")]
		private var FontClass2:Class;
		
		private var headerText:FlxText;
		private var otherText:FlxText;
		private var endtext:FlxText;
		private var beginTime:Number;
		private var scrollspeed:Number = 0.7;
		private var pauzeTime:Number = 3;
		
		public function CreditState() 
		{
			super();
		}
		
		override public function create():void 
		{
			beginTime = FlxG.elapsed;
			headerText = new FlxText(0, 0, 300, "YOU DID IT!");
			headerText.setFormat("AldotheApache", 70);
			headerText.alignment = "center";
			headerText.x = (FlxG.width/2)-150;
			headerText.y = 200;
			
			add(headerText);
			
			otherText = new FlxText(0, 0, 300, "------------Team------------\n\nNerdy Boyz\n\n------------Programmers------------\n\n Bas Roding\nSteven Gunneweg\nHugo Mater\n Stijn Groothuis\n\n------------Artist------------\n\nDennis van Etten\n\n------------Sound Design------------\n\nKyrill Dingelstad\nDennis Reep\n\n------------Level Design------------\n\nDennis van Etten\n\n------------Gameplay Design------------\n\nDennis van Etten\nSteven Gunneweg\nBas Roding\nHugo Mater\nKyrill Dingelstad\nStijn Groothuis\n");
			otherText.setFormat("AldotheApache", 20);
			otherText.alignment = "center";
			otherText.x = (FlxG.width/2)-150;
			otherText.y = 600;
			
			add(otherText);
			
			endtext = new FlxText(0, 0, 300, "-Thank You For Playing-\n\nPress SPACE to restart");
			endtext.setFormat("AldotheApache", 25);
			endtext.alignment = "center";
			endtext.x = (FlxG.width/2)-150;
			endtext.y = otherText.y+otherText.height+450;
			
			add(endtext);
			
			super.create();
			
		}
		
		override public function update():void 
		{
			beginTime += FlxG.elapsed;
			if(beginTime>=pauzeTime){
				otherText.y-=scrollspeed;
				headerText.y -= scrollspeed;
				if(endtext.y >=(500-(endtext.height/2))){
					endtext.y -= scrollspeed;
				}
			}
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.switchState(new LevelState());
			}
			
			super.update();
		}
		
	}

}