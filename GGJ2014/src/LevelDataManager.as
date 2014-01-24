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
		private static var levelList:Array = new Array();
		private var level_amount:int = 1;
		public function LevelDataManager() 
		{
			
		}
		public static function LoadLevelDataList():void {
			levelList = ["1,1", "1,2" ];
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
		private static function errorHandler(event:LoaderEvent):void {
			trace("[LDM] errorHandler");
			
		}
		
		public static function TraceLevelData():void {
			for ( var i:int = 0; i < levelDataList.length ; i++ ) {
			for ( var h:int = 0; h < levelDataList.length ; h++ ) {
				trace(levelDataList[i].layers[h]);
			}
			}
		}
	}

}