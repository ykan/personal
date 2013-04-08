package
{
	import com.yukan.algorithm.Sort;
	import com.yukan.algorithm.sort.FastSort;
	import com.yukan.algorithm.sort.MergeSort;
	import com.yukan.ideas.ArrayTest;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.yukan.algorithm.Recursion;
	import com.yukan.algorithm.interpreter.*;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author yukan
	 */
	public class Main extends Sprite
	{
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			
			
			
			
			
			
			
			
			var arr_test:ArrayTest = new ArrayTest();
			
			//var s:MergeSort = new MergeSort();
			/*var s:FastSort = new FastSort();
			var vet:Vector.<int> = new Vector.<int>();
			vet.push(10, 3, 41, 4, 0, 12, 55, 42, 62, 34);
			s.sort(vet);
			trace("outside");
			for (var i:int = 0; i < vet.length; i++) 
			{
				trace(vet[i]);
			}*/
			
			/*var a:int = 42;
			var b:int = a;
			a = a ^ a;
			a = a ^ a;
			a = a ^ a;
			trace(a,a);*/
			
			
			/*var expman:ExpressionManager = new ExpressionManager();
			var linkedlist:LinkedList = new LinkedList("3.12 + 4.12 - 12 * 11 / 13 * ( ( 12 * 11 - 12 + 3 ) / 3 ) ^ 3");
			linkedlist.showList();
			trace("计算所得值为："+expman.interperter(linkedlist));*/
			
			/*var obj:Object = { value:"(" };
			if (obj.value == ExpressionManager.BRAKET_LEFT) 
			{
				trace("this is a (");
			}*/
			
			
			
			/*var linkedlist:LinkedList = new LinkedList("- 3 + 4 - 12 * 11 / 13 * ( ( 12 * 11 - 12 + 3 ) / 3 ) ^ 3");
			var node:Node = null;*/
			
			/*node = linkedlist.head;
			
			while (node.next != null) 
			{
				trace("当前的Node中的值为：" + node.data.value);
				node = node.next;
			}
			trace("当前的Node中的值为：" + node.data.value);*/
			/*node = linkedlist.tail;
			
			while (node.prev != null) 
			{
				trace("当前的Node中的值为：" + node.data.value);
				node = node.prev;
			}
			trace("当前的Node中的值为：" + node.data.value);*/
			
			
			/*trace("priority:", ExpressionManager.getPriority("/"));
			trace("Number:"+Number("123.123")*3);
			
			var reg:RegExp = /((-?\d+)(\.\d+)?)|\*|\^|(\/)|\+|\-|(\()|(\))/g;
			var expression:String = "- 3.1 + 4 - 12 * 11 / 13 * ( ( 12 * 11 - 12 + 3 ) / 3 ) ^ 3";
			
			var time:Number = getTimer();
			var arr:Array = expression.match(reg);
			time = getTimer() - time;
			trace("cost time:"+time);
			for (var i:int = 0; i < arr.length; i++) 
			{
				trace(arr[i]);
			}*/
			
			//expression = expression.replace(reg, "\t");
			//trace(expression);
			//
		
		/*var arr:Vector.<int> = new Vector.<int>([10, 3, 41, 4, 0, 12, 55, 42, 62, 34, 3]);
		
		   //var s:Sort = new Sort;
		   //s.mergeSort(arr);
		
		   for (var i:int = 0; i < arr.length; i++)
		   {
		   var item:int = arr[i];
		   trace(item+"\t");
		
		 }*/
		
		}
	
	}

}