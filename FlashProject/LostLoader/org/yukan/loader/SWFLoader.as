///////////////////////////////////////////////////////////
//  SWFLoader.as
//  Macromedia ActionScript Implementation of the Class SWFLoader
//  Generated by Enterprise Architect
//  Created on:      30-四月-2011 17:52:18
//  Original author: YuKan
///////////////////////////////////////////////////////////

package org.yukan.loader
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import org.yukan.data.LLItem;

	/**
	 * @author YuKan
	 * @version 1.0
	 * @created 30-四月-2011 17:52:18
	 */
	public class SWFLoader extends AbstractLoader
	{
		public static const type:String = "swf";
		
		private var loader:Loader;
		
	    /**
	     * 
	     * @param resource    url
	     */
	    override public function loadItem(item:LLItem): void
	    {
			loader = new Loader();
			super.loadItem(item);
			
			var urlres:URLRequest = new URLRequest(super.item.url);
			trace(item.url);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, super.progress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, super.ioerror);
			
			loader.load(urlres);
	    }
		override protected function complete(e:Event):void 
		{
			trace("Item load complete.");
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, complete);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, super.progress);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, super.ioerror);
			
			super.item.data = loader.content;
			
			super.complete(e);
		}

	    public function SWFLoader()
	    {
					
	    }
		
	}//end SWFLoader

}