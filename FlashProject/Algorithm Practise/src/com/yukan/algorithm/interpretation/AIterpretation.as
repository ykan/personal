package com.yukan.algorithm.interpretation
{
	import com.yukan.algorithm.interpretation.linkedlist.LinkedList;
	import com.yukan.algorithm.interpretation.linkedlist.Node;
	
	/**
	 * ...
	 * @author YuKan
	 */
	public class AIterpretation implements IIterpretation
	{
		
		public function AIterpretation()
		{
			
		}
		
		
		/* INTERFACE com.yukan.algorithm.interpretation.IIterpretation */
		
		public function interpreter(expression:LinkedList):Node 
		{
			return null;
		}
		
		public function getExpression(opNode:Node, offset:int):LinkedList 
		{
			return null;
		}
	
	}

}