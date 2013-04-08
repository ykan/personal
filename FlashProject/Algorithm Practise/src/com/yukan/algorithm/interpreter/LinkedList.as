package com.yukan.algorithm.interpreter 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class LinkedList 
	{
		private var _currentNode:Node = null;
		private var _head:Node = null;
		private var _tail:Node = null;
		
		public function LinkedList(expression:String = null) 
		{
			if (expression != null) 
				initFromString(expression);
			
			
		}
		//假设表达式为：- 3 + 4 - 12 * 11 / 13 * ( ( 12 * 11 - 12 + 3 ) / 3 ) ^ 3
		/**
		 * 从字符串中初始化链表
		 * @param	experssion
		 */
		public function initFromString(experssion:String):void 
		{
			var getNodeReg:RegExp = /((-?\d+)(\.\d+)?)|\*|\^|(\/)|\+|\-|(\()|(\))/g;
			//var isLegalReg:RegExp = /d/g;
			var tempArr:Array = experssion.match(getNodeReg);
			
			_currentNode = new Node(tempArr[0]);
			_head = _currentNode;
			
			var length:int = tempArr.length -1;
			for (var i:int = 1; i < length; i++) 
			{
				var tempNode:Node = new Node(tempArr[i]);
				_currentNode.next = tempNode;
				_currentNode = tempNode;
				
			}
			_tail = new Node(tempArr[length]);
			_currentNode.next = tail;
			
		}
		
		//测试使用
		public function showList():String
		{
			var node:Node = null;
			var str:String = "";
			
			node = _head;
			while (node != null) 
			{
				str += node.data.value;
				node = node.next;
			}
			trace("当前的List中的值为："+str);
			return str;
		}
		public function showListF():String 
		{
			var node:Node = null;
			var str:String = "";
			
			node = _tail;
			while (node != null) 
			{
				str += node.data.value;
				node = node.prev;
			}
			trace("当前的List中的值为："+str);
			return str;
		}
		
		public function get head():Node 
		{
			/*if(_head ==null && _tail == null)
				throw new Error("This is a null LinkedList");
			
			if (_head ==null) 
			{
				var node:Node = _tail;
				while (node.prev != null) 
				{
					node = node.prev;
				}
				_head = node;
			}*/	
			
			return _head;
		}
		
		public function set head(value:Node):void 
		{
			_head = value;
			_head.prev = null;
		}
		
		public function get tail():Node 
		{
			/*if(_head ==null && _tail == null)
				throw new Error("This is a null LinkedList");
			
			if (_tail ==null) 
			{
				var node:Node = _head;
				while (node.next != null) 
				{
					node = node.next;
				}
				_tail = node;
			}	*/
			
			return _tail;
		}
		
		public function set tail(value:Node):void 
		{
			_tail = value;
			_tail.next = null;
		}
		
		
	}

}