package com.yukan.algorithm.interpreter 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class ExpExpression extends AExpression 
	{
		
		public function ExpExpression() 
		{
			
		}
		public override function interperter(linkedlist:LinkedList):Number 
		{
			var l:Number = linkedlist.head.data.value;
			var r:Number = linkedlist.tail.data.value;
			return Math.pow(l, r);
		}
	}

}