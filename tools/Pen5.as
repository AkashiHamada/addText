package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen5 extends Tools{

		public function Pen5(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "5";
			super(mc,tool_mc);
			
		
			

		
		}
		
		override protected  function exe(){
			super.exe();
			trace("pen5");
			
		}
	

	}
	
}
