package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen4 extends Tools{

		public function Pen4(mc:MovieClip, tool_mc:MovieClip) {
			
			tool_mc.name = "4";
			super(mc,tool_mc);
			

		
		}
		
		override protected  function exe(){
			super.exe();
			trace("pen4");
			
		}
	

	}
	
}
