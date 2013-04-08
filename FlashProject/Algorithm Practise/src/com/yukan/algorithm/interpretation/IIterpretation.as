package com.yukan.algorithm.interpretation 
{
	import com.yukan.algorithm.interpretation.linkedlist.LinkedList;
	import com.yukan.algorithm.interpretation.linkedlist.Node;
	
	/**
	 * ...
	 * @author YuKan
	 */
	public interface IIterpretation 
	{
		/**
		 * 解释字符串
		 * @param	expression：作为要解释的数据源链表对象
		 * @return	返回Node对象
		 */
		function interpreter(expression:LinkedList):Node;
		/**
		 * 根据当前节点，获取本解释器所需的LinkedList
		 * @param	opNode：当前操作符节点
		 * @param	offset：偏移量
		 * @return
		 */
		function getExpression(opNode:Node,offset:int):LinkedList;
	}
	
}