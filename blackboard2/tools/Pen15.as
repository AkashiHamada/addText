package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen15 extends Tools{

		public function Pen15(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "15";
			super(mc,tool_mc);
			
		

		
		}
		
		
		
		override protected function exe(){
			super.exe();
			trace("pen15");
		}
	

	}
	
}