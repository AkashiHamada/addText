package tools {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.CameraRoll;
	import flash.display.BitmapData;
	
	public class Pen2 extends Tools{

		public function Pen2(mc:MovieClip, tool_mc:MovieClip) {
			tool_mc.name = "2";
		
			super(mc,tool_mc);
			

		
		}
		
		override protected  function exe(){
			super.exe();
				if(CameraRoll.supportsAddBitmapData){
					
							
					// カメラロールオブジェクトを作成
					var camera_roll:CameraRoll = new CameraRoll();
					// ビットマップデータを写真フォルダに保存
					camera_roll.addBitmapData(mc.bitmapData);
				
					
				}

			
		}

	}
	
}