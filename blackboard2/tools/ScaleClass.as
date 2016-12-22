package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	public class ScaleClass extends Tools{
		private var panel_sp:Sprite;
		public function ScaleClass(mc:MovieClip, tool_mc:MovieClip) {
			
			tool_mc.name = "4";
			super(mc,tool_mc);
			

		
		}
		
		override protected  function exe(){
			super.exe();
			mc.swtchMode("scale");
			
			panel_sp = new Sprite();
			panel_sp.name = "panel_sp";
			panel_sp.graphics.beginFill(0x55ff44, 1.0);
			panel_sp.graphics.drawRect(0,0,360,350);
			panel_sp.graphics.endFill();
			panel_sp.y = 1090;
			panel_sp.x = 360;
			mc.addChild(panel_sp);
			
		}
		
			override public function remove():void{
				super.remove();
				if( Boolean(mc.getChildByName('panel_sp')) ){
					mc.removeChild(panel_sp);
					panel_sp = null;
				}		
			
			}
	

	

	}
	
}
