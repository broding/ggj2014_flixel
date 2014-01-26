package  
{
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class Score 
	{
		public static var score:uint = 0;
		public static var stepsTaken:uint = 0;
		public static var stepsPerLevel:Array = new Array();
		public static var time:Number = 0;
		public static var timePerLevel:Array = new Array();
		
		public function Score() 
		{
			
		}
		
		public static function AddStepsForLevel():void {
			stepsPerLevel.push(stepsTaken);
			stepsTaken = 0;
		}
		
		public static function AddTimeForLevel():void {
			timePerLevel.push(time);
			time = 0;
		}
		
		public static function ResetLevelScore():void {
			stepsTaken = 0;
			time = 0;
		}
		
		public static function GetLevelScore():uint {
			var result:int = stepsPerLevel[stepsPerLevel.length - 1] - timePerLevel[timePerLevel.length - 1];
			if (result < 0) result = 0;
			return 200 - result;
		}
	}

}