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
		private var levelDataList:Array = new Array();
		private var level_amount:int = 1;
		public function LevelDataManager() 
		{
			
		}
		public static function LoadLevelDataList():void {
			var queue:LoaderMax = new LoaderMax( { name:"LevelLoader", onProgress: progressHandler, onComplete:completeHandler, onError:errorHandler } );
			queue.append(new DataLoader("../assets/levels/1/layer_1.txt", { id:1, layer:1 } ));
			queue.load();
		}
		private static function progressHandler(event:LoaderEvent):void {
			trace("progressHandler");
		}
		private static function completeHandler(event:LoaderEvent):void {
			trace("completeHandler");
			
		}
		private static function errorHandler(event:LoaderEvent):void {
			trace("errorHandler");
			
		}
	}

}