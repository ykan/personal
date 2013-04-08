package yukan.hamster 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.events.FileLoadEvent;
	
	/**
	 * ...
	 * @author yukan
	 */
	public class Hamster3D extends DisplayObject3D
	{
		public static var HamsterV:int = 3;//速度
		
		private const HAMSTER_HIGHTH:Number = 20;
		private const HAMSTER_SCALE:Number = 0.9;
		
		private var _v:Number;//速度
		private var _catchable:Boolean = false;//是否可捕获
		private var _onmove:Boolean = false;//是否在移动
		
		/*
		 *地洞和地鼠 
		 */
		private var hole:DAE;
		private var hamster:DAE;
		
		private var timer:Timer;
		
		public function Hamster3D() 
		{
			super();
			
			hole    = new DAE();
			hamster = new DAE();
			
			timer = new Timer(50);
			
			hole.addEventListener(FileLoadEvent.LOAD_COMPLETE, hole_complete);
			hamster.addEventListener(FileLoadEvent.LOAD_COMPLETE, hamester_complete);
			
			hole.load("resources/assets/model/newHole.dae");
			hamster.load("resources/assets/model/FatHamster.dae");
		}
		
		private function hole_complete(e:FileLoadEvent):void 
		{
			hole.removeEventListener(FileLoadEvent.LOAD_COMPLETE, hole_complete);
			hole.scale = 1.5;
			hole.rotationX = 90;
			addChild(hole);
		}
		
		private function hamester_complete(e:FileLoadEvent):void 
		{
			hamster.removeEventListener(FileLoadEvent.LOAD_COMPLETE, hamester_complete);
			hamster.visible = false;
			hamster.rotationX = 90;
			hamster.scale = 1-HAMSTER_SCALE;
			addChild(hamster);
		}
		
		
		//移动
		private var moveTime:int = 0;
		private var scaleTime:int;
		private var zTime:int;
		
		public function startmove():void 
		{
			_v = Hamster3D.HamsterV;
			
			scaleTime = HAMSTER_SCALE / _v * 5;
			zTime = HAMSTER_HIGHTH / _v;
			
			hamster.visible = true;
			moveTime = 0;
			hamster.scale = 1- HAMSTER_SCALE;
			hamster.z = 0;
			
			timer.addEventListener(TimerEvent.TIMER, hamsterMove);
			timer.start();
			_onmove = true;
		}
		
		private function hamsterMove(e:TimerEvent):void 
		{
			if (moveTime <= scaleTime) 
			{
				hamster.scale += _v / 5;
			}else if(moveTime <= (zTime + scaleTime)) 
			{
				_catchable = true;
				hamster.z += _v;
			}else if(moveTime <= (2 * zTime + scaleTime)) 
			{
				hamster.z -= _v;
			}else if(moveTime <= 2 * (zTime + scaleTime)) 
			{
				_catchable = false;
				hamster.scale -= _v / 5;
			}else 
			{
				timer.stop();
				hamster.visible = false;
				_catchable = false;
				_onmove = false;
				
				moveTime = 0;
				hamster.scale = 1- HAMSTER_SCALE;
				hamster.z = 0;
				
				timer.removeEventListener(TimerEvent.TIMER, hamsterMove);
			}
			moveTime++;
		}
		
		public function stopMove():void 
		{
			timer.stop();
			hamster.visible = false;
			_catchable = false;
			_onmove = false;
			
			moveTime = 0;
			hamster.scale = 1- HAMSTER_SCALE;
			hamster.z = 0;
			
			timer.removeEventListener(TimerEvent.TIMER, hamsterMove);
		}
		//被击打到动作
		public function hittedAction():void 
		{
			
		}
		public function get catchable():Boolean 
		{
			return _catchable;
		}
		
		public function get onmove():Boolean 
		{
			return _onmove;
		}
		
		public function set v(value:Number):void 
		{
			_v = value;
		}
		public function get v():Number
		{
			return _v;
		}
	}

}