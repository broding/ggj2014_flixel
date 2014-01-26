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
		private var _highscoreName:String = "";
		private var _score:int = Score.score;
		private var _highscorelist:Array;
		
		private var _inputfield:FlxText;
		
		public function HighscoreState() 
		{
			_highscorelist = new Array();
			recieveHighscoreList();
			super();
		}
		
		override public function create():void
		{
			
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
			var loader:URLLoader = URLLoader(e.target);

			var data:Array = JSON.decode(loader.data);
			trace(" " + loader.data);
			
			var size:int = data[0].length;
			
			for (var i:int = 0; i < size; i++)
			{
				_highscorelist.push(new HighscorePlayer(data[0][i], data[1][i], (data[2][i] as Date)));
			}
		}
	}
}