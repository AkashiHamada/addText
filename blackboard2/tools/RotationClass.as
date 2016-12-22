package tools {
	import flash.display.MovieClip;

	import flash.events.Event;
	
	public class RotationClass extends Tools{
		
		public function RotationClass(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "5";
			super(mc,tool_mc);
			
		
			

		
		}
		
		override protected  function exe(){
			super.exe();
			mc.swtchMode("rotate");
		
			
			
		}
	}
	
}
