package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Stijn Groothuis
	 */
	public class LoadState extends FlxState
	{
		
		public function LoadState() 
		{
			LevelDataManager.LoadLevelDataList(function():void {
				FlxG.switchState(new MenuState());
				});
			super();
		}
		
	}

}