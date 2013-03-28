package  
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import org.yukan.data.LLItem;
	import org.yukan.data.LLModel;
	import org.yukan.loader.*;
	import org.yukan.loader.SWFLoader;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.yukan.event.LLEvent;
	import org.yukan.event.LLProgressEvent;
	
	import test.TestLoader;
	/**
	 * ...
	 * @author YuKan
	 */
	public class Example extends Sprite 
	{
		//如果要反射出自己的Loader 需要添加一个你的Loader的引用 以保证你的Loader能被编译进swf中
		private var test:TestLoader;
		
		public function Example() 
		{
			var llmodel:LLModel = LLModel.getInstance();
			var loader:LostLoader = new LostLoader("resouce/LostLoaderConfig.xml");
			loader.addEventListener(LLEvent.CONFIG_SUCCESS,function ():void 
			{
				loader.startQueue();
			});
			loader.addEventListener(LLProgressEvent.PROGRESS,function (e:LLProgressEvent):void 
			{
				trace("当前加载LLItem："+e.name+"."+e.datatype+"\t已加载："+e.bytesLoaded/e.bytesTotal+"\n");
			});
			
			loader.addEventListener(LLEvent.QUEUE_COMPLETE,function ():void 
			{
				trace("queue finish");
				
				addChild(Bitmap(llmodel.select("one","img").data));
			});

		}
		
	}

}