///////////////////////////////////////////////////////////
//  ILLIterator.as
//  Macromedia ActionScript Implementation of the Interface ILLIterator
//  Generated by Enterprise Architect
//  Created on:      30-四月-2011 17:52:17
//  Original author: YuKan
///////////////////////////////////////////////////////////

package org.yukan.data
{
	import org.yukan.gc.IGC;
	/**
	 * @author YuKan
	 * @version 1.0
	 * @created 30-四月-2011 17:52:17
	 */
	public interface ILLIterator extends IGC
	{
		/**
		 * 
		 * @param name
		 * @param type    type
		 */
		function add(type:String, name:String, url:String, data:Object = null): void;

		function hasNext(): Boolean;

		function next(): LLItem;

		/**
		 * 
		 * @param name
		 * @param type    type
		 */
		function select(name:String, type:String):LLItem;
		
	}//end ILLIterator

}