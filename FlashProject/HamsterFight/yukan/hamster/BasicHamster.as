package yukan.hamster 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author yukan
	 */
	public class BasicHamster extends MovieClip
	{
		
		public function BasicHamster() 
		{
			var color:uint = 0xffffff * Math.random();
			this.graphics.beginFill(color);
			this.graphics.drawCircle(0, 0, 50);
			this.graphics.endFill();
		}
		
	}

}