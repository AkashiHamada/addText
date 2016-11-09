package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen7 extends Tools{

		public function Pen7(mc:MovieClip, tool_mc:MovieClip) {
			
			tool_mc.name = "7";
			super(mc,tool_mc);
				

		
		}
		
		override protected  function exe(){
			super.exe();
			trace("pen7");
			
		}
	

	}
	
}