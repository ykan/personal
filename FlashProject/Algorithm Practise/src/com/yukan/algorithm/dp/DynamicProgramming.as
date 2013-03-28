package com.yukan.algorithm.dp
{
	
	/**
	 * ...
	 * @author 余侃
	 */
	public class DynamicProgramming
	{
		
		public function DynamicProgramming()
		{
			
		}
		
		/**
		 * 动态规划：找出最长公共子序列
		 * 引索分别使用数字和字符串试试~
		 * @param	x
		 * @param	y
		 * @return
		 */
		public function findMaxList(x:Array, y:Array):Array
		{
			var result:Array;
			var v:Vector.<Vector.<int>> = new Vector.<Vector.<uint>>(x.length);
			for (var i:int = 0; i < x.length; i++) 
			{
				v[i] = new Vector.<uint>(y.length);
			}
			result = findSameList(x, y, v);
			return result;
		}
		private function findSameList(x:Array, y:Array,c:Vector.<Vector.<uint>>):Array
		{
			var result:Array = [];
			var m:uint = x.length - 1;
			var n:uint = y.length - 1;
			if (m>0 && n>0 && x[m]==y[n]) 
			{
				
			}
			else if (m==0 && n==0) 
				return result;
		}
	}

}