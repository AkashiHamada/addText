package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen extends Tools{

		public function Pen(mc:MovieClip, tool_mc:MovieClip) {
			super(mc,tool_mc);
			tool_mc.name = "1";
			
			
			

		
		}
		
		public function exe(){
			super();
			trace("pen");
		}
		
		
		
	

	}
	
}
