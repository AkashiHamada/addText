//// 書き込み
package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Undo extends Tools{
		private var cnt:uint =0
		public function Undo(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "6";
			super(mc,tool_mc);	

		
		}
		
		override protected  function exe(){
			super.exe();
	
			var cnt:uint = mc.bitmapData_cnt--;
			//
			//ビットマップデータをすり替える。
			mc.bitmap.bitmapData = mc.bitmapData_arr[cnt];
			
	
			
		}
	

	}
	
}
