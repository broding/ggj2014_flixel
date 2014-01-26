package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.*;
	import com.adobe.serialization.json.*;
	import mx.core.FlexTextField;

	import org.flixel.*;
	/**
	 * ...
	 * @author Stijn Groothuis
	 */
	public class HighscoreState extends FlxState
	{
		[Embed(source = "../assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF = "false", mimeType = "application/x-font")]
		private var FontClass2:Class;
		
		private var website:String = /*"http://localhost/GGJ2014/highscores.php";//*/ "http://oege.ie.hva.nl/~mater09/GGJ2014/recieveHighscores.php";
		private var _highscorelist:Array;
		
		private var _text:FlxText;
		private var _placeText:FlxText;
		private var _nameText:FlxText;
		private var _scoreText:FlxText;
		private var _dateText:FlxText;
		
		public function HighscoreState() 
		{
			_highscorelist = new Array();
			recieveHighscoreList();
			super();
		}
		
		public function makeHighscorelist():void
		{
			
			_text = new FlxText(0, 0, FlxG.width, "WorldWide Highscore:");
			_text.y = 5;
			_text.scrollFactor.make(0,0);
			_text.setFormat("AldotheApache", 40, 0xffffff);
			_text.alignment = "center";
			
			_placeText = new FlxText(0, 0, 60, "");
			_placeText.scrollFactor.make(0, 0);
			_placeText.y = 55;
			_placeText.x = (FlxG.width / 10);
			_placeText.setFormat("AldotheApache", 19, 0xffffff);
			
			_nameText = new FlxText(0, 0, 200, "");
			_nameText.scrollFactor.make(0, 0);
			_nameText.y = 55;
			_nameText.x = (FlxG.width / 5);
			_nameText.setFormat("AldotheApache", 19, 0xffffff);
			
			_scoreText = new FlxText(0, 0, 150, "");
			_scoreText.scrollFactor.make(0, 0);
			_scoreText.y = 55;
			_scoreText.x = (FlxG.width / 5) * 3;
			_scoreText.setFormat("AldotheApache", 19, 0xffffff);
			
			_dateText = new FlxText(0, 0, 200, "");
			_dateText.scrollFactor.make(0, 0);
			_dateText.y = 55;
			_dateText.x = FlxG.width - (FlxG.width / 5);
			_dateText.setFormat("AldotheApache", 19, 0xffffff);
			
			var placeString:String = "Place: \n\n";
			var nameString:String = "Name: \n\n";
			var scoreString:String = "Score: \n\n";
			var dateString:String = "Date: \n\n";
			
			for (var i:int = 0; i < _highscorelist.length; i++)
			{
				placeString += ("#" + (i + 1) + "\n");
				nameString += _highscorelist[i].name + "\n";
				scoreString += _highscorelist[i].score + "\n";
				dateString += _highscorelist[i].date + "\n";
			}
			_placeText.text = placeString;
			_nameText.text = nameString;
			_scoreText.text = scoreString;
			_dateText.text = dateString;
			
			add(_placeText);
			add(_nameText);
			add(_scoreText);
			add(_dateText);
			add(_text);
		}
		
		override public function update():void
		{
			if(FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new MenuState());
			}
			
			if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.switchState(new MenuState());
			}
		}
		
		private function recieveHighscoreList():void
		{
			var myRequest:URLRequest = new URLRequest(website);
			myRequest.method = URLRequestMethod.POST;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, submitComplete);
			loader.load(myRequest);
		}
		
		private function submitComplete(e:Event):void
		{
			//*
			var loader:URLLoader = URLLoader(e.target);

			var data:Array = JSON.decode(loader.data);
			
			var size:int = data[0].length;
			
			for (var i:int = 0; i < size; i++)
			{
				_highscorelist.push(new HighscorePlayer(data[0][i], data[1][i], (data[2][i] as String)));
			}
			makeHighscorelist();
		}
	}
}