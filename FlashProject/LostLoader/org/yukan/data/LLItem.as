package org.yukan.data 
{
	/**
	 * ...
	 * @author YuKan
	 */
	public class LLItem 
	{
		public var num:uint;
		public var type:String;
		public var name:String;
		public var url:String;
		public var data:Object = null;
		
		public function LLItem(num:uint,type:String,name:String,url:String,data:Object = null)
		{
			this.num = num;
			this.type = type;
			this.name = name;
			this.url = url;
			this.data = data;
		}
	}

}