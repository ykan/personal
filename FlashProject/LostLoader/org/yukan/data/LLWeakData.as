package org.yukan.data 
{
	import flash.utils.Dictionary;
	import org.yukan.gc.IGC;
	/**
	 * ...
	 * @author YuKan
	 */
	public class LLWeakData implements IGC, ILLIterator 
	{
		private var dict:Dictionary = new Dictionary(true);
		private var position:uint = 0;
		private var length:uint = 0;
		
		public function LLWeakData() 
		{
			
		}
		/**
	     * 
	     * @param name
	     * @param type    type
	     */
	    public function add(type:String, name:String, url:String, data:Object = null): void
	    {
			length++;
			var temp:LLItem = new LLItem(length,type,name,url,data);
			dict[temp] = null;
	    }

	    public function hasNext(): Boolean
	    {
			if (length > position) 
				return true;
			
			return false;
	    }

	    public function next(): LLItem
	    {
			position++;
			if (position == length) 
				position = 0;
			
			for (var item in dict) 
			{
				if (item.num == position) 
					return item;
			}
			
			return null;
	    }

	    /**
	     * 
	     * @param name
	     * @param type    type
	     */
	    public function select(name:String, type:String):LLItem
	    {
			for (var item in dict) 
			{
				if (item.name == name && item.type == type) 
					return item;
			}
			return null;
	    }
		
		//IGC
		public function dispose():void 
		{
			
		}
		
	}

}