package  
{
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class HighscorePlayer 
	{
		private var _name:String;
		private var _score:int;
		private var _date:Date;
		
		public function HighscorePlayer(name:String, score:int, date:Date) 
		{
			this._name = name;
			this._score = score;
			this._date = date;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get score():int 
		{
			return _score;
		}
		
		public function get date():Date 
		{
			return _date;
		}
		
	}

}