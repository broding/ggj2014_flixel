package
{
	import flash.events.*;
	import flash.net.*;
	import com.adobe.serialization.json.*;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.flixel.*;
	
	public class SubmitState extends FlxState
	{
		private var website:String = /*"http://localhost/GGJ2014/highscores.php";//*/ "http://oege.ie.hva.nl/~mater09/GGJ2014/highscores.php";
		private var _score:int = Score.score;
		private var _highscorelist:Array;
		
		private var _text:FlxText;
		private var _input:FlxInputText;
		
		private var _checker:ConnectionChecker;
		
		public function SubmitState()
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			_text = new FlxText(0, 0, FlxG.width, "Enter your name:");
			_text.y = 220;
			_text.scrollFactor.make(0,0);
			_text.setFormat("AldotheApache", 40, 0xffffff);
			_text.alignment = "center";
			
			_input = new FlxInputText(0, 300, "", FlxG.width);
			_input.alignment = "center";
			_input.size = 30;
			_input.text = "Your name bitte";
			_input.text = "";
			_input.hasFocus = true;
			
			_checker = new ConnectionChecker();
			
			Score.score = 0;
			
			add(_text);
			add(_input);
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.justPressed("ENTER"))
			{
				submit();
			}
			
			if (FlxG.keys.justPressed("ESCAPE"))
				FlxG.switchState(new MenuState());
		}
		
		private function checker_success(event:Event):void
		{
			submit();
		}

		private function checker_error(event:Event):void
		{
			FlxG.switchState(new MenuState());
		}
		
		private function submit():void
		{
			var myRequest:URLRequest = new URLRequest(website);
			myRequest.method = URLRequestMethod.POST;
			
			var variables:URLVariables = new URLVariables();
			variables.name = _input.text;
			variables.score = _score;
			myRequest.data = variables;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, submitComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError)
			loader.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			try
            {
				loader.load(myRequest);
            }
            catch ( e:Error )
            {
                onError(null);
            }
		}
		
		private function onError(e:Event):void
		{
			FlxG.switchState(new MenuState());
		}
		
		private function submitComplete(e:Event):void
		{
			FlxG.switchState(new HighscoreState());
		}
	}
}