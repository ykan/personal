package com.yukan.algorithm.interpreter 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class MultiExpression extends AExpression 
	{
		
		public function MultiExpression() 
		{
			
		}
		public override function interperter(linkedlist:LinkedList):Number 
		{
			var l:Number = linkedlist.head.data.value;
			var r:Number = linkedlist.tail.data.value;
			return (l*r);
		}
	}

}