package com.yukan.algorithm.interpreter 
{
	/**
	 * ...
	 * @author 余侃
	 */
	public class ExpressionManager extends AExpression 
	{
		public static const EXP			:String = "^";
		public static const BRAKET_LEFT	:String = "(";
		public static const BRAKET_RIGHT:String = ")";
		public static const MULTI		:String = "*";
		public static const DIVISION	:String = "/";
		public static const PLUS		:String = "+";
		public static const MINUS		:String = "-";
		
		private var braketExp:BraketExpression;
		
		public function ExpressionManager() 
		{
			braketExp = new BraketExpression();
		}
		public override function interperter(linkedlist:LinkedList):Number 
		{
			return braketExp.interperter(linkedlist);
		}
		
		public static function getPriority(operation:String):uint 
		{
			switch (operation) 
			{
				case EXP:
					return 1;
				case BRAKET_LEFT:
				case BRAKET_RIGHT:
					return 0;
				case MULTI:
				case DIVISION:
					return 2;
				case PLUS:
				case MINUS:
					return 3;
				default:
					return 100;
			}
		}
		
		public static function getExpression(operation:String):AExpression
		{
			switch (operation) 
			{
				case EXP:
					return new ExpExpression();
				case BRAKET_LEFT:
				case BRAKET_RIGHT:
					return new BraketExpression();
				case MULTI:
					return new MultiExpression();
				case DIVISION:
					return new DivisionExpression();
				case PLUS:
					return new PlusExpression();
				case MINUS:
					return new MinusExpression();
				default:
					throw new Error("没有这个表达式");
			}
		}
	}

}