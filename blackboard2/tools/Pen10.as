package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen10 extends Tools{

		public function Pen10(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "10";
			super(mc,tool_mc);
			
		

		
		}
		
		
		
		override protected function exe(){
			super.exe();
			trace("pen10");
		}
		
	

	}
	
}