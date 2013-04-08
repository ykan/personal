package com.yukan.algorithm.sort 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class MergeSort implements ISort
	{
		
		public function MergeSort() 
		{
			
		}
		
		/* INTERFACE com.yukan.algorithm.sort.ISort */
		
		public function sort(vet:Vector.<int>):Vector.<int> 
		{
			return mergeSort(vet, 0, vet.length - 1);
		}
		
		private function mergeSort(vet:Vector.<int>,left:int,right:int):Vector.<int> 
		{
			var result:Vector.<int>;
			var rightV:Vector.<int>;
			var leftV:Vector.<int>;
			if (left < right) 
			{
				var i:int = (right + left) / 2;
				leftV = mergeSort(vet, left, i);
				rightV = mergeSort(vet, i + 1, right);
				
				result = merge(leftV,rightV);
				
			}else 
			{
				result  = new Vector.<int>();
				result.push(vet[left]);
				
			}
			return result;
		}
		
		private function merge(lv:Vector.<int>,rv:Vector.<int>):Vector.<int> 
		{
			var result:Vector.<int> = new Vector.<int>();
			var i:int = 0, j:int = 0;
			while (i<lv.length && j<rv.length) 
			{
				if (lv[i]<rv[j]) 
				{
					result.push(lv[i]);
					i++;
				}else 
				{
					result.push(rv[j]);
					j++;
				}
			}
			if (i<lv.length) 
			{
				for (; i < lv.length; i++) 
				{
					result.push(lv[i]);
				}
			}
			
			if (j<rv.length) 
			{
				for (; j < rv.length; j++) 
				{
					result.push(rv[j]);
				}
			}
			
			return result;
		}
	}

}