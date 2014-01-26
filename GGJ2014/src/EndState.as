package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.*;
	import com.adobe.serialization.json.*;

	import org.flixel.*;
	/**
	 * ...
	 * @author Stijn Groothuis
	 */
	public class EndState extends FlxState
	{
		[Embed(source = "../assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF = "false", mimeType = "application/x-font")]
		private var FontClass2:Class;
		
		private var headerText:FlxText;
		private var website:String = /*"http://localhost/GGJ2014/highscores.php";//*/ "http://oege.ie.hva.nl/~mater09/GGJ2014/highscores.php";
		
		private var _highscoreName:String = "name";
		private var _score:int = 0;
		
		private var otherText:FlxText;
		private var endtext:FlxText;
		private var beginTime:Number;
		private var scrollspeed:Number = 0.7;
		private var pauzeTime:Number = 3;
		private var _highscorelist:Array;
		public function EndState() 
		{
			_highscorelist = new Array();
			
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
			endtext.y = otherText.y+otherText.height+350;
			
			add(endtext);
			
			super.create();
			
			submit();
		}
		
		override public function update():void 
		{
			beginTime += FlxG.elapsed;
			if(beginTime>=pauzeTime){
				otherText.y-=scrollspeed;
				headerText.y -= scrollspeed;
				if(endtext.y >=(300-(endtext.height/2))){
					endtext.y -= scrollspeed;
				}
			}
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.switchState(new LevelState());
			}
			
			super.update();
		}
		
		private function submit(/*e:MouseEvent*/):void
		{
			var myRequest:URLRequest = new URLRequest(website);
			myRequest.method = URLRequestMethod.POST;
			
			var variables:URLVariables = new URLVariables();
			variables.name = _highscoreName;
			variables.score = _score;
			myRequest.data = variables;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, submitComplete);
			loader.load(myRequest);
		}
		
		private function submitComplete(e:Event):void
		{
			var loader:URLLoader = URLLoader(e.target);
			trace("completeHandler: " + loader.data);

			var data:Array = JSON.decode(loader.data);
			
			var size:int = data[0].length;
			
			for (var i:int = 0; i < size; i++)
			{
				_highscorelist.push(new HighscorePlayer(data[0][i], data[1][i], (data[2][i] as Date)));
			}
			
			trace("Nr 1: " + _highscorelist[0].name);
		}
	}
}