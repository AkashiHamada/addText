package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen12 extends Tools{

		public function Pen12(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "12";
			super(mc,tool_mc);
			
		

		
		}
		
		
		
		override protected function exe(){
			super.exe();
			trace("pen12");
		}
	

	}
	
}