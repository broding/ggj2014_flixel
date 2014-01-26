package
{
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.flixel.*;
	
	public class SubmitState extends FlxState
	{
		private var _text:FlxText;
		private var _input:FlxInputText;
		
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
			
			add(_text);
			add(_input);
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.keys.justPressed("ENTER"))
			{
				// var _input.getText() ofzoiets meegeven!!!
				FlxG.switchState(new EndState());
			}
		}
	}
}