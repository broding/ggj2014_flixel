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
	}

}