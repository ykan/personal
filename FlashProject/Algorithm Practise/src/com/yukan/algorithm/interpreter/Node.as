package com.yukan.algorithm.interpreter 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class Node 
	{
		public static const NUMBER:String = "number";
		public static const OPERATION:String = "operation";
		
		private var _prev:Node = null;
		private var _next:Node = null;
		private var _data:Object;
		
		public function Node(value:String) 
		{
			setData(value);
		}
		private function setData(value:String):void 
		{
			var reg:RegExp = /^(-?\d+)(\.\d+)?$/;
			
			if (reg.exec(value)) 
			{
				_data = { type:Node.NUMBER, value:value };
			}else 
			{
				_data = { type:Node.OPERATION, value:value, priority:ExpressionManager.getPriority(value) };
			}
		}
		public function get prev():Node 
		{
			return _prev;
		}
		
		public function set prev(value:Node):void 
		{
			_prev = value;
			if (_prev != null && _prev.next == null) 
			{
				_prev.next = this;
			}
		}
		
		public function get next():Node 
		{
			return _next;
		}
		
		public function set next(value:Node):void 
		{
			_next = value;
			if (_next != null && _next.prev ==null) 
			{
				_next.prev = this;
			}
		}
		
		public function get data():Object 
		{
			return _data;
		}
		
		public function set data(value:Object):void 
		{
			_data = value;
		}
		
		
	}

}