package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen16 extends Tools{

		public function Pen16(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "16";
			super(mc,tool_mc);
			
		

		
		}
		
		
		
		override protected function exe(){
			super.exe();
			trace("pen16");
		}
	

	}
	
}