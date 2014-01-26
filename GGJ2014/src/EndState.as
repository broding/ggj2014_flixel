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
	public class EndState extends FlxState
	{
		[Embed(source = "../assets/fonts/AldotheApache.ttf", fontName = "AldotheApache", embedAsCFF = "false", mimeType = "application/x-font")]
		private var FontClass2:Class;
		
		private var website:String = /*"http://localhost/GGJ2014/highscores.php";//*/ "http://oege.ie.hva.nl/~mater09/GGJ2014/highscores.php";
		private var _highscoreName:String = "";
		private var _score:int = Score.score;
		private var _highscorelist:Array;
		private var _highscoreWindow:HighscoreWindow;
		
		private const WIDTH:int = 500;
		private const HEIGHT:int = 550;
		
		private var _bg:FlxSprite;
		private var _title:FlxText;
		private var _levelScoreText:FlxText;
		private var _totalScoreText:FlxText;
		
		private var _inputfield:FlxText;
		
		public function EndState() 
		{
			_highscorelist = new Array();
			
			super();
		}
		
		override public function create():void
		{
			
			_title = new FlxText(0, 0, FlxG.width, "Highscore:");
			_title.y = 50;
			_title.scrollFactor.make(0,0);
			_title.setFormat("AldotheApache", 30, 0xFFFFFF);
			_title.alignment = "center";
			_title.visible = false;
			
			_levelScoreText = new FlxText(0, 0, FlxG.width, "Your score:");
			_levelScoreText.y = 80;
			_levelScoreText.scrollFactor.make(0,0);
			_levelScoreText.setFormat("AldotheApache", 40, 0xFFFFFF);
			_levelScoreText.alignment = "center";
			
			_totalScoreText = new FlxText(0, 0, FlxG.width, _score.toString());
			_totalScoreText.y = 140;
			_totalScoreText.scrollFactor.make(0,0);
			_totalScoreText.setFormat("AldotheApache", 72, 0xFFFFFF);
			_totalScoreText.alignment = "center";
			
			/*_inputfield = new FlexTextField();
			_inputfield.background = true;
			_inputfield.backgroundColor = 0xFFFFFF;
			_inputfield.selectable = true;	
			_inputfield.thickness = 2;*/
			
			
			add(_title);
			add(_levelScoreText);
			add(_totalScoreText);
		}
		
		public function notSubmittedYet():void
		{
			
		}
		
		private function submit():void
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

			var data:Array = JSON.decode(loader.data);
			
			var size:int = data[0].length;
			
			for (var i:int = 0; i < size; i++)
			{
				_highscorelist.push(new HighscorePlayer(data[0][i], data[1][i], (data[2][i] as Date)));
			}
		}
	}
}