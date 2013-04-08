package com.yukan.algorithm.sort 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class FastSort implements ISort 
	{
		
		public function FastSort() 
		{
			var vet:Vector.<int> = new Vector.<int>();
			vet.push(10, 3, 41, 4, 0, 12, 55, 42, 62, 34);
			swap(vet, 7, 7);
		}
		
		/* INTERFACE com.yukan.algorithm.sort.ISort */
		
		public function sort(vet:Vector.<int>):Vector.<int> 
		{
			return fastSort(vet, 0, vet.length - 1);
		}
		private function fastSort(vet:Vector.<int>,left:int,right:int):Vector.<int> 
		{
			
			if (left < right) 
			{
				var compare:int = vet[left];
				var i:int = left, j:int = right;
				while (i < j) 
				{
					while (vet[i] <= compare && i < right)
						i++;
					while (vet[j]>compare) 
						j--;
					
					if (i>=j) 
						break;
					swap(vet, i, j);
				}
				swap(vet, left, j);
				
				fastSort(vet, left, j - 1);
				fastSort(vet,j + 1, right);
				
			}
			return vet;
		}
		
		
		private function swap(vet:Vector.<int>,i:int,j:int):void
		{
			trace("in exchange:"+i+":"+vet[i]+"->"+j+":"+vet[j]);
			/*vet[i] = vet[i] ^ vet[j];
			//trace("exchange:"+i+":"+vet[i]+"->"+j+":"+vet[j]);
			vet[j] = vet[i] ^ vet[j];
			//trace("exchange:"+i+":"+vet[i]+"->"+j+":"+vet[j]);
			vet[i] = vet[i] ^ vet[j];
			//trace("exchange:"+i+":"+vet[i]+"->"+j+":"+vet[j]);*/
			
			var temp:int = vet[i];
			vet[i] = vet[j];
			vet[j] = temp;
			trace("out exchange:"+i+":"+vet[i]+"->"+j+":"+vet[j]);
		}
	}

}