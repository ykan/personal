package com.yukan.algorithm.interpreter 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class MinusExpression extends AExpression 
	{
		
		public function MinusExpression() 
		{
			
		}
		public override function interperter(linkedlist:LinkedList):Number 
		{
			var l:Number = 0;
			var r:Number = linkedlist.tail.data.value;
			
			if (linkedlist.head.data.type == Node.NUMBER) 
			{
				l = linkedlist.head.data.value;
			}
			
			return (l-r);
		}
	}

}