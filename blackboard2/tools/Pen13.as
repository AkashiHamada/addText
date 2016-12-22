package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen13 extends Tools{

		public function Pen13(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "13";
			super(mc,tool_mc);
			
		

		
		}
		
		
		
		override protected function exe(){
			super.exe();
			trace("pen13");
			
		}
		
	

	}
	
}