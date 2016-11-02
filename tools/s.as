package tools {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Tools extends MovieClip {
			public var mc:MovieClip;
			public var tool_mc:MovieClip;
		public function Tools(mc:MovieClip, tool_mc:MovieClip) {
			this.mc = mc;
			this.tool_mc = tool_mc;

			mc.lane.addChild(tool_mc);
			mc.lane.addEventListener(MouseEvent.MOUSE_UP, mouseUP);
		}
		
		/*override protected function exe(){
			
		}*/
		
		public function mouseUP(e:MouseEvent):void{
			mc.lane.removeChild(tool_mc);
			mc.lane.removeEventListener(MouseEvent.MOUSE_UP, mouseUP);
			tool_mc = null;
		}

	}
	
}
