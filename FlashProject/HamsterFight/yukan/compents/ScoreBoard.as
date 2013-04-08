package  yukan.compents{
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	public class ScoreBoard extends MovieClip {
		
		private var timer:Timer;
		private var _timeisover:Boolean = false;
		
		
		public function ScoreBoard() {
			// constructor code
			timer = new Timer(1000,100);
		}
		
		public function startCount():void 
		{
			timer.addEventListener(TimerEvent.TIMER, timeCountDown);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCom);
			
			timebar.scaleX = 1;
			_timeisover = false;
			timer.reset();
			timer.start();
			
		}
		private function timeCountDown(e:TimerEvent):void 
		{
			timebar.scaleX -= 0.01;
		}
		private function timerCom(e:TimerEvent):void 
		{
			_timeisover = true;
			timer.removeEventListener(TimerEvent.TIMER, timeCountDown);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCom);
		}
		
		public function resetCount():void 
		{
			timebar.scaleX = 1;
			score = 0;
			level = 1;
			_timeisover = false;
			timer.reset();
		}
		public function set score(value:uint):void 
		{
			scoreText.text = String(value);
		}
		public function get score():uint 
		{
			return uint(scoreText.text);
		}
		public function set level(value:uint):void 
		{
			levelText.text = String(value);
		}
		public function get level():uint 
		{
			return uint(levelText.text);
		}
		public function get timeisover():Boolean 
		{
			return _timeisover;
		}
	}
	
}
