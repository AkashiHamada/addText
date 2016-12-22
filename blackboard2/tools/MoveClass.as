package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class MoveClass extends Tools{

		public function MoveClass(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "3";
			super(mc,tool_mc);

		
		}
		
		override protected  function exe(){
			super.exe();
			mc.swtchMode("move");
			
			
			
		}
	

	}
	
}
