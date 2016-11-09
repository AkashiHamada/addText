package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen14 extends Tools{

		public function Pen14(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "14";
			super(mc,tool_mc);
			
		

		
		}
		
		
		
		override protected function exe(){
			super.exe();
			trace("pen14");
		}
	

	}
	
}