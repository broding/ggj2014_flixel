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
			var result:uint = stepsTaken;
			for (var i:int = 0; i < stepsPerLevel.length; i++) {
				result -= stepsPerLevel[i];
			}
			stepsPerLevel.push(result);
		}
		
		public static function AddTimeForLevel():void {
			var result:uint = time;
			for (var i:int = 0; i < timePerLevel.length; i++) {
				result -= timePerLevel[i];
			}
			timePerLevel.push(result);
		}
	}

}