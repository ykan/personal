package com.yukan.algorithm 
{
	/**
	 * ...
	 * @author yukan
	 */
	public class Recursion
	{
		
		public function Recursion() 
		{
			
		}
		
		public static function fibonacci(n:int):int
		{
			if (n <= 1) return 1;
			return fibonacci(n - 1) + fibonacci(n - 2);
		}
		//
		public  static function hanoi(n:int,a:int,b:int,c:int):void 
		{
			if (n>0) 
			{
				hanoi(n - 1, a, c, b);
				move(a, b);
				hanoi(n - 1, c, b, a);
			}
		}
		private static function move(a:int,b:int):void 
		{
			
		}
	}

}