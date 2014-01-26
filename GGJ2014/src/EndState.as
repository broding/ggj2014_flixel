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
		
		private var _levelName:FlxText;
		private var website:String = /*"http://localhost/GGJ2014/highscores.php";//*/ "http://oege.ie.hva.nl/~mater09/GGJ2014/highscores.php";
		
		private var _highscoreName:String = "name";
		private var _score:int = 0;
		
		private var _highscorelist:Array;
		public function EndState() 
		{
			_highscorelist = new Array();
			
			super();
		}
		
		override public function create():void 
		{
			_levelName = new FlxText(0, 0, 300, "YOU DID IT!");
			_levelName.size = 60;
			_levelName.alignment = "center";
			_levelName.x = (FlxG.width/2)-150;
			_levelName.y = 200;
			
			add(_levelName);
			super.create();
			
			submit();
		}
		
		override public function update():void 
		{
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