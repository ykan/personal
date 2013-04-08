package  
{
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	import flash.display.Bitmap;
	import org.yukan.data.LLItem;
	import org.yukan.data.LLModel;
	import org.yukan.loader.*;
	import org.yukan.loader.SWFLoader;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.yukan.event.LLEvent;
	import org.yukan.event.LLProgressEvent;
	
	import com.demonsters.debugger.MonsterDebugger;
	import test.TestLoader;
	/**
	 * ...
	 * @author YuKan
	 */
	public class Main extends Sprite 
	{
		private var debugger:MonsterDebugger;
		private var loader:SWFLoader;
		private var test:test.TestLoader;
		
		public function Main() 
		{
			trace("work");
			MonsterDebugger.initialize(this);
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
				
				MonsterDebugger.trace(this, llmodel.next());
				while (llmodel.hasNext()) {
					MonsterDebugger.trace(this, llmodel.next());
				}
				//trace(String(llmodel.select("two","txt").data));
				//addChild(Sprite(llmodel.select("two", "swf").data));
				addChild(Bitmap(llmodel.select("two", "img").data));
			});
			
			//trace(AbstractLoader.type,"\n",SWFLoader.type);
			/*var swfloader:SWFLoader = new SWFLoader();
			swfloader.addEventListener(LLEvent.ITEM_COMPLETE,function ():void 
			{
				trace("workfsdg");
			});
			swfloader.loadItem(new LLItem(1, "swf", "1", "resource/swf/1.swf"));*/
			
			/*var llmodel:LLModel = LLModel.getInstance();
			var swfloader:ILoader = llmodel.selectLoader("img");
			var bloader:ILoader = llmodel.selectLoader("bin");
			
			trace(bloader.type);*/
			
			
			
			
			//
			//
			//
			//llmodel.add("type","name",  "www.baidu.com");
			//trace(llmodel.hasNext());
			//trace(llmodel.next().url);
			//trace(llmodel.select("name","type").url);
			
			//var type:XML = 	
			//<type>
				//<loader type="xml">org.yukan.loader::XMLLoader</loader>
				//<loader type="bin">org.yukan.loader::BINLoader</loader>
			//</type>;
			//MonsterDebugger.trace(this,type);				
			//for each(var loader:XML in type.loader) 
			//{
				//MonsterDebugger.trace(this,loader);
			//}
			
			//var resource:XML = 
			//<resource>
				//<data type="swf">
					//<element name="yukan">yukan.swf</element>
				//</data>
				//<data type="img">
					//<element name="yukan">yukan.jpg</element>
				//</data>
				//<data type="txt">
					//<element name="yukan">yukan.txt</element>
				//</data>
				//<data type="bin">
					//<element name="yukan">yukan.bin</element>
				//</data>	
			//</resource>;
			//
			//for each(var i:XML in resource.data) 
			//{
				//
				//for each (var j:XML in i.element) 
				//{
					//MonsterDebugger.trace(this, j);
					//trace("resource type:"+i.@type+"\tname:"+j.@name+"\turl:"+j);
				//}
			//}
		}
		
	}

}