package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen9 extends Tools{

		public function Pen9(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "9";
			super(mc,tool_mc);
			
		

		
		}
		
		
		override protected function exe(){
			super.exe();
			trace("pen9");
		}
		
	

	}
	
}