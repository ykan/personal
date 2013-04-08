package yukan.compents 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author yukan
	 */
	public class LostAlert extends Sprite
	{
		private var msgbox:MessageBox;
		
		public function LostAlert() 
		{
			msgbox = new MessageBox;
		}
		
		public function show(message:String):void 
		{
			msgbox.message.htmlText = message;
			msgbox.ok_btn.addEventListener(MouseEvent.CLICK, okClicked);
			addChild(msgbox);
		}
		private function okClicked(e:MouseEvent):void 
		{
			removeChild(msgbox);
			dispatchEvent(new Event("lost_alert_ok"));
		}
		
	}

}