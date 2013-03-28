package com.yukan.algorithm 
{
	/**
	 * ...
	 * @author YuKan
	 */
	public class Sort 
	{
		private static var THRESHOLD:int = 10;
		public function Sort() 
		{
			
		}
		
		//合并排序
		public function mergeSort(data:Vector.<int>):void 
		{
			var temp:Vector.<int> = new Vector.<int>(data.length);
			sort(data, temp, 0, data.length - 1);
		}
		
		private function sort(data:Vector.<int>,temp:Vector.<int>,ins:int,r:int):void 
		{
			var i:int, j:int, k:int;
			var mid:int = (ins + r) / 2;
			
			if (ins == r) 
			{
				return;
			}
			
			if ((mid-ins)>=THRESHOLD) 
			{
				sort(data, temp, ins, mid);
			}else 
			{
				insertsort(data, ins, mid);
			}
			
			if ((r-mid) > THRESHOLD) 
			{
				sort(data, temp, mid + 1, r);
			}else 
			{
				insertsort(data, mid + 1, r - mid);
			}
			
			for (i = ins; i < mid; i++) 
			{
				temp[i] = data[i];
			}
			for (j = 0; j <= r - mid; j++) 
			{
				temp[r - j + 1] = data[j + mid];
				
			}
			
			var a:int = temp[ins];
			var b:int = temp[r];
			
			for (i=ins,j=r,k=ins; k<=r; k++) 
			{
				if (a<b) 
				{
					data[k] = temp[i++];
					a = temp[i]
				}else 
				{
					data[k] = temp[j--];
					b = temp[j]
				}
				
			}
		}
		
		private function insertsort(data:Vector.<int>,start:int,len:int):void 
		{
			for (var i:int = start+1; i < start+len; i++) 
			{
				for (var j:int = i; (j>start)&&data[j]<data[j-1];j--) 
				{
					var item:int = data[j];
					data[j] = data[j - 1];
					data[j - 1] = item;
					
				}
				
			}
		}
	}

}