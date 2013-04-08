package  
{
	import com.transmote.flar.FLARManager;
	import com.transmote.flar.camera.FLARCamera_PV3D;
	import com.transmote.flar.marker.FLARMarker;
	import com.transmote.flar.marker.FLARMarkerEvent;
	import com.transmote.flar.tracker.FLARToolkitManager;
	import com.transmote.flar.utils.geom.PVGeomUtils;
	import com.transmote.utils.time.FramerateDisplay;
	
	import flash.events.StatusEvent;
	import flash.events.ErrorEvent;
	import flash.media.Camera;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.net.FileReference;	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoaderDataFormat;
	import fl.video.FLVPlayback;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import yukan.compents.ScoreBoard;
	import yukan.hamster.Hamster3D;
	import yukan.hamster.BasicHamster;
	import yukan.compents.LostAlert;
	
	
	import org.libspark.flartoolkit.support.pv3d.FLARCamera3D;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.render.LazyRenderEngine;
	import org.papervision3d.render.QuadrantRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	/**
	 * ...
	 * @author yukan
	 */
	public class HamsterFight extends MovieClip
	{
		//FLARManger
		private var flarmanager:FLARManager;
		private var activeMarker:Vector.<FLARMarker>;	
		
		private var debugger:MonsterDebugger;
		
		//Papervision 场景
		private var scene3D:Scene3D;
		private var camera3D:Camera3D;
		private var viewport3D:Viewport3D;
		private var renderEngine:LazyRenderEngine;
		private var pointLight3D:PointLight3D;
		
		private var activeHam:Array;//正在活动的地鼠模型
		private var hamster:Vector.<Hamster3D>;//地鼠数组
		private var scoreboard:ScoreBoard;
		private var lostAlert:LostAlert;
		
		//视频组件
		private var flvPlay:FLVPlayback;
		
		//音效
		private var hittedSound:Sound;
		
		//游戏状态
		private const GAME_INIT:int = 20;//游戏初始化
		private const GAME_START:int = 10;//游戏开始
		private const GAME_PLAY:int = 30;//游戏中
		private const GAME_OVER:int = 40;//游戏结束
		private const SYSTEM_WAIT:int = 0;//系统暂停
		
		private var gameState:int = 0;//状态变量
		
		public function HamsterFight() 
		{
			if (stage) 
				init();
			else 
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//debugger = new MonsterDebugger(this);
			
			//预载
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, preloadProgress);
			loaderInfo.addEventListener(Event.COMPLETE, preloadCom);
			
		}
		
		//预载
		private function preloadProgress(e:ProgressEvent):void 
		{
			var pct:int = e.bytesLoaded / e.bytesTotal*100;
			trace("Preload:"+pct+"%");
			percent.text = pct+"%";
		}
		private function preloadCom(e:Event):void
		{
			//removeChild(preloadLogo);
			//removeChild(percent);
			//removeChild(ell);
			
			gotoAndStop(2);
			flvplayback.playheadTime = 0.7;
			//创建游戏时钟
			addEventListener(Event.ENTER_FRAME, gameloop);
			
			gameState = GAME_START;
		}
		
		//游戏状态循环
		private function gameloop(e:Event):void 
		{
			trace(gameState);
			switch (gameState) 
			{
				case GAME_START:
					gamestart();
					break;
				case GAME_INIT:
					gameInit();
					break;
				case GAME_PLAY:
					playgame();
					break;
				case GAME_OVER:
					gameover();
					break;
			}
		}
		//游戏开始界面
		private function gamestart():void 
		{
			gameState = SYSTEM_WAIT;
			//flvplayback = flvPlay;
			save_btn.addEventListener(MouseEvent.CLICK, onSaveBtn);
			start_btn.addEventListener(MouseEvent.CLICK, onStartBtn);
			
			//初始化警告框
			lostAlert = new LostAlert;
			lostAlert.x = 320;
			lostAlert.y = 240;
			addChild(lostAlert);
		}
		private function onStartBtn(e:MouseEvent):void 
		{
			gameState = GAME_INIT;
			flvplayback.stop();
			gotoAndStop(3);
		}
		private var urlloader:URLLoader;
		//保存标记文件
		private function onSaveBtn(e:MouseEvent):void 
		{
			urlloader = new URLLoader();
			urlloader.addEventListener(Event.COMPLETE, loadMarkerFileCom);
			urlloader.dataFormat = URLLoaderDataFormat.BINARY;
			urlloader.load(new URLRequest("resources/flarToolkit/patterns/patterns01.pdf"));
		}
		private function loadMarkerFileCom(e:Event):void 
		{
			var ba:ByteArray = ByteArray(urlloader.data);
			var file:FileReference = new FileReference;
			file.save(ba,"marker.pdf");
			
		}
		
		//游戏初始化
		private function gameInit():void 
		{
			gameState = SYSTEM_WAIT;
			flarmanager = new FLARManager("resources/flar/flarConfig.xml", new FLARToolkitManager, stage);
			
			//Sprite(flarmanager.flarSource).scaleY = -1;
			//Sprite(flarmanager.flarSource).y = 480;
			addChild(Sprite(flarmanager.flarSource));
			
			var framerate:FramerateDisplay = new FramerateDisplay;
			framerate.x = 600;
			addChild(framerate);
			
			
			//加载一些场景声音
			loadSound();
			
			flarmanager.addEventListener(FLARMarkerEvent.MARKER_ADDED, markerAdded);
			flarmanager.addEventListener(FLARMarkerEvent.MARKER_UPDATED, markerUpdated);
			flarmanager.addEventListener(FLARMarkerEvent.MARKER_REMOVED, markerRemoved);
			
			flarmanager.addEventListener(Event.INIT, flarmanagerInit);
			
		}
		private function cameraAccepted(e:Event):void 
		{
			scoreboard.startCount();
		}
		//加载一些场景声音
		private function loadSound():void 
		{
			hittedSound = new HitSound();
		}
		
		//FLARManager初始化完成
		private function flarmanagerInit(e:Event):void 
		{
			flarmanager.removeEventListener(Event.INIT, flarmanagerInit);
			
			//创建Papervision场景
			scene3D = new Scene3D();
			viewport3D = new Viewport3D(stage.stageWidth, stage.stageHeight);
			//viewport3D.scaleY = -1;
			//viewport3D.y = 480;
			addChild(viewport3D);
			
			camera3D = new FLARCamera_PV3D(flarmanager, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			
			//renderEngine = new QuadrantRenderEngine(QuadrantRenderEngine.CORRECT_Z_FILTER);
			renderEngine = new LazyRenderEngine(scene3D, camera3D, viewport3D);
			//pointLight3D = new PointLight3D();
			//pointLight3D.x = 1000;
			//pointLight3D.y = 1000;
			//pointLight3D.z = -1000;
			
			//创建hamster数组 和 Marker数组
			hamster = new Vector.<Hamster3D>(12);
			activeMarker = new Vector.<FLARMarker>(12);
			
			for (var i:int = 0; i < 12; i++) 
			{
				hamster[i] = new Hamster3D();
				scene3D.addChild(hamster[i]);
				hamster[i].visible = false;
			}
			activeHam = new Array;
			
			
			//创建计分板
			scoreboard = new ScoreBoard;
			scoreboard.alpha = 0.8;
			addChild(scoreboard);
			setChildIndex(lostAlert, numChildren - 1);
			//scoreboard.startCount();
			flarmanager.flarCameraSource.addEventListener("camera_accepted", cameraAccepted);
			flarmanager.flarCameraSource.addEventListener(ErrorEvent.ERROR, noCamera);
			
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			//游戏状态转入GAME_PLAY
			gameState = GAME_PLAY;
		}
		private function noCamera(e:ErrorEvent):void 
		{
			lostAlert.show("对不起，您仍需安装一个摄像头。");
		}
		private function markerAdded(e:FLARMarkerEvent):void 
		{
			var tempid:int = e.marker.patternId;
			hamster[tempid].visible = true;
			activeMarker[tempid] = e.marker;
			activeHam[tempid] = tempid;
			activeNum++;
		}
		
		private function markerUpdated(e:FLARMarkerEvent):void 
		{
			activeMarker[e.marker.patternId] = e.marker;
		}
		
		private function markerRemoved(e:FLARMarkerEvent):void 
		{
			var tempid:int = e.marker.patternId;
			hamster[tempid].visible = false;
			activeMarker[tempid] = null;
			activeHam[tempid] = null;
			activeNum--;
			//假如当前地鼠状态为可捕捉且倾覆策略返回false则击打
			if (hamster[tempid].catchable && !overremove) 
			{
				hitAhamster(tempid);
			}
		}
		
		private function onEnterFrame(e:Event):void 
		{
			for (var i:int = 0; i < 12; i++) 
			{
				if (activeMarker[i]) 
				{
					hamster[i].transform = PVGeomUtils.convertMatrixToPVMatrix(this.activeMarker[i].transformMatrix, this.flarmanager.flarSource.mirrored);
				}
			}
			
			//renderEngine.renderScene(scene3D,camera3D,viewport3D);
			renderEngine.render();
		}
		
		//击打到了一个地鼠
		private function hitAhamster(hamsterid:int):void
		{
			trace("Hit a hamster.");
			scoreboard.score += 100;
			hittedSound.play();
			hamster[hamsterid].stopMove();
		}
		
		//进行游戏
		private var activeNum:int = 0;
		private var   lastNum:int = 0;
		private var waitframe:int = 0;
		
		private var overremove:Boolean = false;
		
		private const WAIT_FRAME:int = 3;
		
		private function playgame():void 
		{
			//判断是否盖上过多数Marker
			waitframe++;
			if (waitframe >= WAIT_FRAME) 
			{
				overremove = false;
				waitframe = 0;
				lastNum = activeNum;
			}
			
			if ((activeNum - lastNum)>3) 
				overremove = true;
			
			trace(overremove);
			//地鼠移动
			hamstermove();
			//是否要改变等级
			checkLevel();
			//计时是否结束
			if (scoreboard.timeisover) 
			{
				gameState = GAME_OVER;
			}
		}
		private function hamstermove():void 
		{
			var temp:int = activeNum / 2 + 1;
			for each (var i:int in activeHam) 
			{	
				if (hamster[i].onmove) 
					temp --;
			}
			for each (i in activeHam) 
			{
				if (Math.random() > 0.5 && temp >0 && !hamster[i].onmove) 
				{
					temp --;
					hamster[i].startmove();
				}
			}
		}
		private function checkLevel():void 
		{
			if (scoreboard.level * 3000 < scoreboard.score) 
			{
				scoreboard.level ++;
				Hamster3D.HamsterV = 3 + scoreboard.level / 2;
			}
		}
		//游戏结束
		private function gameover():void 
		{
			trace("Game over");
			gameState = SYSTEM_WAIT;
			lostAlert.show("恭喜您获得了<br/><font color='#ffff00' size='30'>" + scoreboard.score + "分</font><br/>您想要再来一次么？");
			lostAlert.addEventListener("lost_alert_ok", okaccepted);
		}
		private function okaccepted(e:Event):void 
		{
			gameState = GAME_PLAY;
			scoreboard.resetCount();
			scoreboard.startCount();
		}
	}

}