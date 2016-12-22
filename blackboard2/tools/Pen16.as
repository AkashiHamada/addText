package tools {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TouchEvent;
	
	public class Pen16 extends Tools{
		private var panel_sp:Sprite;
		private var remove_btn:Sprite;

		public function Pen16(mc:MovieClip, tool_mc:MovieClip) {
				tool_mc.name = "1";
			super(mc,tool_mc);
			
		
		
		}
		
		
		override protected function exe(){
			super.exe();
			
			
			panel_sp = new Sprite();
			panel_sp.graphics.beginFill(0x55ff44, 1.0);
			panel_sp.graphics.drawRect(0,0,720,650);
			panel_sp.graphics.endFill();
			panel_sp.y = 950;
			
			remove_btn = new Sprite();
			remove_btn.graphics.lineStyle(5.0,0x333333,0.8);
			remove_btn.graphics.beginFill(0xff0000,1.0);
			remove_btn.graphics.drawRect(0,0,80,80);
			remove_btn.graphics.lineStyle(10.0, 0xffffff);
			remove_btn.graphics.moveTo(10,10);
			remove_btn.graphics.lineTo(70,70);
			remove_btn.graphics.moveTo(10,70);
			remove_btn.graphics.lineTo(70,10);
			remove_btn.graphics.endFill();
			
			
			panel_sp.addChild(remove_btn);
			mc.addChild(panel_sp);
		
			remove_btn.addEventListener(TouchEvent.TOUCH_BEGIN, remove_btnFunc);
	
		}
		
		
		 public function remove_btnFunc(e:TouchEvent):void{
				remove_btn.removeEventListener(TouchEvent.TOUCH_BEGIN, remove_btnFunc);
				panel_sp.removeChild(remove_btn);
				mc.removeChild(panel_sp);
				panel_sp = null;
				remove_btn = null;
			}
	

	}
	
}