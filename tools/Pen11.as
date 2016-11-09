package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen11 extends Tools{

		public function Pen11(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "11";
			super(mc,tool_mc);
			
		

		
		}
		
	
		
		override protected function exe(){
			super.exe();
			trace("pen11");
		}
	

	}
	
}