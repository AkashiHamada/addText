package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen2 extends Tools{

		public function Pen2(mc:MovieClip, tool_mc:MovieClip) {
			super(mc,tool_mc);
			tool_mc.name = "2";
			tool_mc.y = 950;
			tool_mc.x = 80;

		
		}
		
		override protected function exe(){
			
		}
		
	

	}
	
}