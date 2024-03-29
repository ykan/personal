///////////////////////////////////////////////////////////
//  ImageLoader.as
//  Macromedia ActionScript Implementation of the Class ImageLoader
//  Generated by Enterprise Architect
//  Created on:      30-四月-2011 17:52:17
//  Original author: YuKan
///////////////////////////////////////////////////////////

package org.yukan.loader
{
	import flash.display.Loader;
	import org.yukan.data.LLItem;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	/**
	 * @author YuKan
	 * @version 1.0
	 * @created 30-四月-2011 17:52:17
	 */
	public class ImageLoader extends AbstractLoader
	{
		public static const type:String = "img";
		
		private var loader:Loader;
		
	    public function ImageLoader()
	    {
			
	    }

	    /**
	     * 
	     * @param resource    url
	     */
	    override public function loadItem(item:LLItem): void
	    {
			loader = new Loader;
			super.loadItem(item);
			
			var urlres:URLRequest = new URLRequest(super.item.url);
			
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

	}//end ImageLoader

}