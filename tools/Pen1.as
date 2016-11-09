package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Pen1 extends Tools{

		public function Pen1(mc:MovieClip, tool_mc:MovieClip) {
				tool_mc.name = "1";
			super(mc,tool_mc);
			
		
		}
		
		/*override protected function exe(){
			
		}*/
		override protected function exe(){
			super.exe();
			trace("pen1");
		}
	

	}
	
}
