package components
{
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Utils3D;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;

	public class jsInterface extends UIComponent
	{
		
		private function timerHandler(event:TimerEvent):void {
			var isReady:Boolean = checkJavaScriptReady();
			if (isReady) {
				Alert.show("JavaScript is ready.\n");
				Timer(event.target).stop();
			}
		}
		
		
		private function checkJavaScriptReady():Boolean {
			var isReady:Boolean = ExternalInterface.call("isReady");
			return isReady;
		}
		
		
		private function receivedFromJavaScript(value:String):void {
			Alert.show("JavaScript says: " + value + "\n");
		}
		
		
		public function callJavaScript():void
		{
			ExternalInterface.addCallback("sendToActionScript", receivedFromJavaScript);
			
			if ( checkJavaScriptReady()) {
				Alert.show("Javascript is ready. \n");
			} else {
				Alert.show("JavaScript is not ready, creating timer.\n");
				var readyTimer:Timer = new Timer(100, 0);
				readyTimer.addEventListener(TimerEvent.TIMER, timerHandler);
				readyTimer.start();
			}
		}
		
		
		public function jsInterface()
		{
			if ( ExternalInterface.available )
			{
				
			}
		}
	}
}