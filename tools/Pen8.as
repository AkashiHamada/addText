package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen8 extends Tools{

		public function Pen8(mc:MovieClip, tool_mc:MovieClip) {
			
			tool_mc.name = "8";
			super(mc,tool_mc);
			

		
		}
	  
		
		
		override protected function exe(){
			super.exe();
			trace("pen8");
		}
	

	}
	
}