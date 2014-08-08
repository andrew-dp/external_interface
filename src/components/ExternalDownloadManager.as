package components
{
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * Singleton 
	 * @author aguard
	 * 
	 */
	public class ExternalDownloadManager
	{
		private static var instance:ExternalDownloadManager;
		
		protected var _bytes:ByteArray;
		
		protected var urlCallbackMap:Dictionary;
		
		public function download(url:String, callback:Function):void
		{
			ExternalInterface.call('loadFile', url);
			urlCallbackMap[url] = callback;
		}
		
		private function onJavaScriptDownloadComplete(url:String, stream:String):void
		{
			var callback:Function = urlCallbackMap[url];
			callback(stream);
			delete urlCallbackMap[url];
		}
		
		public static function getInstance():ExternalDownloadManager
		{
			if ( instance == null )
			{
				instance = new ExternalDownloadManager(new SingletonBlocker());
			}
			return instance;
		}
		
		public function ExternalDownloadManager(p_key:SingletonBlocker)
		{
			if (p_key == null)
			{
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
			ExternalInterface.addCallback("executeCallback", onJavaScriptDownloadComplete);
			urlCallbackMap = new Dictionary();
		}
	}
}

internal class SingletonBlocker {}
