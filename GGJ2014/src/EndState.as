package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Stijn Groothuis
	 */
	public class EndState extends FlxState
	{
		
		private var _levelName:FlxText;
		public function EndState() 
		{
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
		}
		override public function update():void 
		{
			if (FlxG.keys.justPressed("SPACE")) {
				FlxG.switchState(new LevelState());
			}
			
			super.update();
		}
	}

}