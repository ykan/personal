package  
{
	import flash.events.Event;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.events.FileLoadEvent;
	
	/**
	 * ...
	 * @author yukan
	 */
	public class HamsterTest extends BasicView
	{
		private var hole:DAE;
		private var hamster:DAE;
		
		public function HamsterTest() 
		{
			hole    = new DAE();
			hamster = new DAE();
			
			hole.addEventListener(FileLoadEvent.LOAD_COMPLETE, complete);
			hamster.addEventListener(FileLoadEvent.LOAD_COMPLETE, complete);
			
			hole.load("resources/assets/model/hole.dae");
			hamster.load("resources/assets/model/mouse.dae");
			
			startRendering();
		}
		
		private function complete(e:FileLoadEvent):void 
		{
			DAE(e.currentTarget).scale = 20;
			scene.addChild(DAE(e.currentTarget));
			trace(e.currentTarget);
			
		}
		
		protected override function onRenderTick(e:Event= null):void 
		{
			hole.x ++;
			hamster.x ++;
			
			super.onRenderTick();
		}
		
	}

}