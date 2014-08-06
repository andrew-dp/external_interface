package components
{
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	
	import mx.utils.Base64Decoder;

	public class HTTPStreamDownloader
	{
		
		protected var _bytes:ByteArray;
		
		public function open(url:String):void
		{
			var downloadManager:ExternalDownloadManager = ExternalDownloadManager.getInstance();
//			downloadManager.download(url, function);
		}
		
		protected function saveBytes(stream:String):void
		{
			var streamDecoder:Base64Decoder = new Base64Decoder();
			streamDecoder.decode(stream);
			_bytes = streamDecoder.toByteArray();
			trace("_bytes when saved: " + _bytes)
		}
		
		public function getBytes():IDataInput
		{
			trace("_bytes when retreived: " + _bytes);
			return _bytes;
		}
		
		public function HTTPStreamDownloader()
		{
		}
	}
}