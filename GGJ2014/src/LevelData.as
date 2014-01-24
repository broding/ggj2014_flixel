package
{
	public class LevelData
	{
		private var _id:uint;
		private var _layers:Vector.<String>;
		private var _name:String;
		
		public function LevelData(id:uint, name:String)
		{
			_id = id;
			_layers = new Vector.<String>();
			_name = name;
		}

		public function get name():String
		{
			return _name;
		}

		public function get layers():Vector.<String>
		{
			return _layers;
		}

		public function get id():uint
		{
			return _id;
		}

	}
}