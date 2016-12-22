package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Redo extends Tools{

		public function Redo(mc:MovieClip, tool_mc:MovieClip) {
			
			tool_mc.name = "7";
			super(mc,tool_mc);
			

		
		}
	  
		
		
		override protected function exe(){
			super.exe();
			trace("redo");
		
			trace("undo cnt:" + mc.bitmapData_cnt);
			if(mc.bitmapData_cnt< mc.bitmapData_arr.length -1){
					var cnt:uint = ++(mc.bitmapData_cnt);
				mc.bitmap.bitmapData = mc.bitmapData_arr[cnt];
			}
	

		}
	}
}