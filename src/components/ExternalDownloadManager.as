package components
{
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	
	import mx.utils.Base64Decoder;

	/**
	 * Singleton 
	 * @author aguard
	 * 
	 */
	public class ExternalDownloadManager
	{
		private static var instance:ExternalDownloadManager;
		
		protected var _bytes:ByteArray;
		
		protected var _callback:Function;
		
		public function download(url:String, callback:Function):void
		{
			ExternalInterface.call('loadFile', url);
			_callback = callback;
			ExternalInterface.addCallback("executeCallback", executeCallback);
		}
		
		private function executeCallback(stream:String):void
		{
			_callback(stream);
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
		}
	}
}

internal class SingletonBlocker {}