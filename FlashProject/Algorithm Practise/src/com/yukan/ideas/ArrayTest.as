package com.yukan.ideas 
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author ...
	 */
	public class ArrayTest 
	{
		private var quantity:uint;
		private const TEN:uint = 10;
		private const HUN:uint = 100;
		private const THA:uint = 1000;
		private const TTH:uint = 10000;
		
		private var time:uint = 0;
		
		public function ArrayTest() 
		{
			var i:int, j:int, k:int, l:int, m:int, n:int;
			var arr_n:Array = [];//正常方法创建
			var arr_s:Array = [];//关联数组
			
			/* 初始化 */
			quantity = THA;
			trace("当前quantity为：" + quantity);
			////二维
			//Normal
			time = getTimer();
			for (i = 0; i < quantity; i++) 
			{
				arr_n[i] = [];
				for (j = 0; j < quantity; j++)
					arr_n[i][j] = 1;
			}
			time = getTimer() -time;
			trace("二维Normal方法初始化数组所化时间为：" + time+"ms");
			
			//My
			time = getTimer();
			for (i = 0; i < quantity; i++) 
				for (j = 0; j < quantity; j++)
					arr_s[i + "," + j] = 1;
					
			time = getTimer() -time;
			trace("二维关联数字初始化所化时间为："+time+"ms");
			
			//////////////////////////////////////////////////////////////
			////三维
			/*time = getTimer();
			for (i = 0; i < quantity; i++) 
			{
				arr_n[i] = [];
				for (j = 0; j < quantity; j++)
				{
					arr_n[i][j] = [];
					for (k = 0; k < quantity; k++)
						arr_n[i][j][k] = 1;
				}
			}
			time = getTimer() -time;
			trace("二维Normal方法初始化数组所化时间为：" + time);
			
			//My
			time = getTimer();
			for (i = 0; i < quantity; i++) 
				for (j = 0; j < quantity; j++)
					for (k = 0; k < quantity; k++)
						arr_s[i+","+j+","+k] = 1;
			
			time = getTimer() -time;
			trace("二维关联数字初始化所化时间为："+time);*/
			
			//////////////////////////////////////////////////////////////
			////四维
			
			
		}
		
	}

}