package com.yukan.algorithm.interpreter 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class PlusExpression extends AExpression 
	{
		
		public function PlusExpression() 
		{
			
		}
		public override function interperter(linkedlist:LinkedList):Number 
		{
			var l:Number = linkedlist.head.data.value;
			var r:Number = linkedlist.tail.data.value;
			return (l+r);
		}
	}

}