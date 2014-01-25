package  
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.LoaderMax;
	
	/**
	 * ...
	 * @author Stijn Groothuis
	 */
	public class LevelDataManager 
	{
		private static var queue:LoaderMax = new LoaderMax( { name:"LevelLoader", onProgress: progressHandler, onComplete:completeHandler, onError:errorHandler } );;
		private static var levelDataList:Array = new Array();
		private static var _levelList:Array = new Array();

		public static function get levelList():Array
		{
			return _levelList;
		}

		private static var _callback:Function;
		private var level_amount:int = 1;
		public function LevelDataManager() 
		{
			
		}
		public static function LoadLevelDataList(callback:Function):void {
			_callback = callback;
			_levelList = ["1,1", "2,1","2,2","3,1","3,2","3,3" , "4,1" , "4,2" ,"4,3" ];
			for ( var i:int = 0; i < levelList.length ; i++ ) {
				AppendMap(levelList[i].split(",")[0], levelList[i].split(",")[1]);	
			}
			queue.load();
		}
		public static function AppendMap(_map:int, _layer:int):void {
			queue.append(new DataLoader("../assets/levels/" + _map + "/" + _layer + ".txt", {name:""+_map+","+_layer+"", id:_map, layer: _layer } ));
		}
		private static function progressHandler(event:LoaderEvent):void {
			trace("[LDM] progressHandler");
			
		}
		private static function completeHandler(event:LoaderEvent):void {
			trace("[LDM] completeHandler");
			for ( var i:int = 0; i < levelList.length ; i++ ) {
				var data:String = LoaderMax.getContent(levelList[i]);
				GetLevelData(int(levelList[i].split(",")[0])).layers.push(data);
			}
			_callback.call();
		}
		private static function GetLevelData(id:int):LevelData {
			for ( var i:int = 0; i < levelDataList.length ; i++ ) {
				if (levelDataList[i].id == id) {
					return levelDataList[i];
				}
			}
			var tempdata:LevelData = new LevelData(id, "kees the pancake");
			levelDataList.push(tempdata);
			return tempdata;
		}
		public static function getLevelData(id:int):LevelData {
			for ( var i:int = 0; i < levelDataList.length ; i++ ) {
				if (levelDataList[i].id == id) {
					return levelDataList[i];
				}
			}
 			throw new Error("[LDM] level does not exist");
		}
		private static function errorHandler(event:LoaderEvent):void {
			trace("[LDM] errorHandler");
			
		}
		
		public static function TraceLevelData():void {
			for ( var i:int = 0; i < levelDataList.length ; i++ ) {
			for ( var h:int = 0; h < levelDataList[i].layers.length ; h++ ) {
				trace("TRACE LEVELDATA");
				trace(levelDataList[i].layers[h]);
			}
			}
		}
	}

}