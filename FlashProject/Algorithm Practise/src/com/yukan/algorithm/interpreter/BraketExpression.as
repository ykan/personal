package com.yukan.algorithm.interpreter 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class BraketExpression extends AExpression 
	{
		private var exp:Array;
		
		public function BraketExpression() 
		{
			exp = new Array();
			exp[ExpressionManager.PLUS] 	= new PlusExpression();
			exp[ExpressionManager.MINUS] 	= new MinusExpression();
			exp[ExpressionManager.MULTI] 	= new MultiExpression();
			exp[ExpressionManager.DIVISION] = new DivisionExpression();
			exp[ExpressionManager.EXP] 		= new ExpExpression();
		}
		//假设表达式为：3 + 4 - 12 * 11 / 13 * ( ( 12 * 11 - 12 + 3 ) / 3 ) ^ 3
		//：3+4-12*11/13*2012
		public override function interperter(linkedlist:LinkedList):Number 
		{
			var result:Number;
			
			var templist:LinkedList = new LinkedList;
			var temphead:Node = null;
			var temptail:Node = null;
			var tempnode:Node = null;
			
			var bra_r:Node = null;
			var bra_l:Node = null;
			var isOver:int = 0;
			var pos:Node = null;
			
			pos = linkedlist.head;
			
			while (pos != null) 
			{
				if (pos.data.value == ExpressionManager.BRAKET_LEFT && isOver == 0) 
				{
					//trace("这是第一个左括弧");
					isOver ++;
					bra_l = pos;
				}else if(pos.data.value == ExpressionManager.BRAKET_LEFT)
				{
					
					isOver ++;
					//trace("增加一个左括弧"+isOver);
				}
				if(pos.data.value == ExpressionManager.BRAKET_RIGHT && bra_l != null)
				{
					isOver --;
					//trace("增加一个右括弧" + isOver);
					if (isOver == 0) {
						//trace("这是对应的一个右括弧");
						bra_r = pos;
						
						temphead = bra_r.next;
						temptail = bra_l.prev;
						
						templist.head = bra_l.next;
						templist.tail = bra_r.prev;
						
						//test
						//trace("this is");
						//templist.showList();
						
						tempnode = new Node(String(interperter(templist)));
						if (temptail != null && temphead != null) {
							temptail.next = tempnode;
							tempnode.prev = temptail;
							tempnode.next = temphead;
							temphead.prev = tempnode;
							
						}else if(temphead != null)
						{
							//trace("此时的temphead中的值："+temphead.data.value);
							temphead.prev = tempnode;
							linkedlist.head = tempnode;
						}else if(temptail != null)
						{
							temptail.next = tempnode;
							linkedlist.tail = tempnode;
						}
						//trace("deal");
						//trace("此时的temphead",temphead,"此时的temphail",temptail);
						//linkedlist.showList();
						//linkedlist.showListF();
					}
				}
				
				pos = pos.next;
			}
			//test
			//trace("tatal");
			//linkedlist.showList();
			
			//关键问题：链表是不是有下一个？
			
			var node:Vector.<Node> = new Vector.<Node>(3);
			
			var current:uint = 0;
			
			pos = linkedlist.head;
			while (pos != null) 
			{
				//trace("当前current中的值为："+current);
				if (pos.data.type == Node.OPERATION) 
				{
					//trace("当前节点为操作时，current中的值为："+current);
					switch (current) 
					{
						case 0:
							node[0] = pos;
							current ++;
						break;
						case 1:
							//加入第一个操作符的优先级 <= 第二个的优先级，则进行计算
							//trace("当前current为："+current);
							node[1] = pos;
							current ++;
							//trace("当前pos中的值为：" + pos.data.value);
							//trace("node[0]中的值为：",node[0].data.value,"node[1]中的值为：",node[1].data.value);
							if (node[0].data.priority <= node[1].data.priority) 
							{
								//trace("node[0]中前一个和后一个的值：", node[0].prev, node[0].next);
								//trace("noded[0]中的值和下一个的值：",node[0].data.value,node[0].next.data.value)
								temphead = node[0].next.next;
								temptail = node[0].prev.prev;
								
								templist.head = node[0].prev;
								templist.tail = node[0].next;
								
								//test
								//trace("操作为：");
								//templist.showList();
								
								tempnode = new Node(String(exp[node[0].data.value].interperter(templist)));
								//trace("单个操作计算结果为："+tempnode.data.value);
								if (temptail != null && temphead != null) {
									temptail.next = tempnode;
									tempnode.prev = temptail;
									tempnode.next = temphead;
									temphead.prev = tempnode;
								}else if(temphead != null)
								{
									temphead.prev = tempnode;
									linkedlist.head = tempnode;
								}else if(temptail != null)
								{
									temptail.next = tempnode;
									linkedlist.tail = tempnode;
								}
								//trace("计算单个的操作完成");
								//trace("此时linkedlist中的值：");
								//linkedlist.showList();
								
								//计算完成 移动node
								pos = linkedlist.head;
								current = 0;
								node[0] = null;
								node[1] = null;
							}
						break;
						case 2:
							//加入第一个操作符的优先级 <= 第二个的优先级，则进行计算
							//trace("当前current为："+current);
							node[2] = pos;
							//trace("当前pos中的值为：" + pos.data.value);
							//trace("node[1]中的值为：",node[1].data.value,"node[2]中的值为：",node[2].data.value);
							if (node[1].data.priority <= node[2].data.priority) 
							{
								//trace("node[0]中前一个和后一个的值：", node[0].prev, node[0].next);
								//trace("noded[0]中的值和下一个的值：",node[0].data.value,node[0].next.data.value)
								temphead = node[1].next.next;
								temptail = node[1].prev.prev;
								
								templist.head = node[1].prev;
								templist.tail = node[1].next;
								
								//test
								//trace("操作为：");
								//templist.showList();
								
								tempnode = new Node(String(exp[node[1].data.value].interperter(templist)));
								//trace("单个操作计算结果为："+tempnode.data.value);
								if (temptail != null && temphead != null) {
									temptail.next = tempnode;
									tempnode.prev = temptail;
									tempnode.next = temphead;
									temphead.prev = tempnode;
								}else if(temphead != null)
								{
									temphead.prev = tempnode;
									linkedlist.head = tempnode;
								}else if(temptail != null)
								{
									temptail.next = tempnode;
									linkedlist.tail = tempnode;
								}
								//trace("计算单个的操作完成");
								//trace("此时linkedlist中的值：");
								//linkedlist.showList();
								//计算完成 移动node
								pos = linkedlist.head;
								current = 0;
								node[0] = null;
								node[1] = null;
								node[2] = null;
							}else 
							{
								temphead = node[2].next.next;
								temptail = node[2].prev.prev;
								
								templist.head = node[2].prev;
								templist.tail = node[2].next;
								
								//test
								//trace("操作为：");
								//templist.showList();
								
								tempnode = new Node(String(exp[node[2].data.value].interperter(templist)));
								//trace("单个操作计算结果为："+tempnode.data.value);
								if (temptail != null && temphead != null) {
									temptail.next = tempnode;
									tempnode.prev = temptail;
									tempnode.next = temphead;
									temphead.prev = tempnode;
								}else if(temphead != null)
								{
									temphead.prev = tempnode;
									linkedlist.head = tempnode;
								}else if(temptail != null)
								{
									temptail.next = tempnode;
									linkedlist.tail = tempnode;
								}
								//trace("计算单个的操作完成");
								
								
								//计算完成 移动node
								pos = linkedlist.head;
								current = 0;
								node[0] = null;
								node[1] = null;
								node[2] = null;
							}
						break;
						default:
					}
				}
				//trace("当前current中的值为："+current);
				pos= pos.next;
			}
			
			if (node[0] != null && node[1] ==null) 
			{
				templist.head = node[0].prev;
				templist.tail = node[0].next;
				
				//test
				//trace("最后的操作为：");
				//templist.showList();
				return exp[node[0].data.value].interperter(templist);
			}
			if (node[0] != null && node[1] !=null) 
			{
				temphead = node[1].next.next;
				temptail = node[1].prev.prev;
				
				templist.head = node[1].prev;
				templist.tail = node[1].next;
				
				//test
				//trace("操作为：");
				//templist.showList();
				
				tempnode = new Node(String(exp[node[1].data.value].interperter(templist)));
				//trace("单个操作计算结果为："+tempnode.data.value);
				if (temptail != null && temphead != null) {
					temptail.next = tempnode;
					tempnode.prev = temptail;
					tempnode.next = temphead;
					temphead.prev = tempnode;
				}else if(temphead != null)
				{
					temphead.prev = tempnode;
					linkedlist.head = tempnode;
				}else if(temptail != null)
				{
					temptail.next = tempnode;
					linkedlist.tail = tempnode;
				}
				
				templist.head = node[0].prev;
				templist.tail = node[0].next;
				
				//test
				//trace("最后的操作为：");
				//templist.showList();
				return exp[node[0].data.value].interperter(templist);
			}
			
			return Number(linkedlist.head.data.value);
			//return 2012;
		}
	}

}