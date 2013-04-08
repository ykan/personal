package org.yukan.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author YuKan
	 */
	public class LLProgressEvent extends Event 
	{
		public static const PROGRESS:String = "progress";
		
		public var bytesLoaded:uint = 0;
		public var bytesTotal:uint = 0;
		public var num:uint=0;
		public var name:String;
		public var datatype:String;
		
		public function LLProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			var temp:LLProgressEvent = new LLProgressEvent(type, bubbles, cancelable);
			temp.bytesLoaded = this.bytesLoaded;
			temp.bytesTotal = this.bytesTotal;
			temp.num = this.num;
			temp.name = this.name;
			temp.datatype = this.datatype;
			
			return temp;
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LLProgressEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}