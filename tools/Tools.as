package tools {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Tools extends MovieClip {
			public var mc:MovieClip;
			public var tool_mc:MovieClip;
	
	
		public function Tools(mc:MovieClip, tool_mc:MovieClip) {
			this.mc = mc;
			this.tool_mc = tool_mc;

			mc.lane.addChild(tool_mc);
			mc.lane.addEventListener(MouseEvent.MOUSE_UP, mouseUP);
			
			
			
			
			
				var i:uint =0;
			for(i; i<18; i++){
				if(mc.toolOnLane[i][0] == -1){
					mc.toolOnLane[i][0] =tool_mc.name;
					tool_mc.x = mc.toolOnLane[i][1];
					tool_mc.y = mc.toolOnLane[i][2];

					break;
				}
				
			}
		}
		
		 protected function exe(){
			
		}
		
		public function mouseUP(e:MouseEvent):void{
			var tmp_name:String = tool_mc.name;// 一時的な変数
			
			var i:uint =0;
			for(i; i<18; i++){
				if(mc.toolOnLane[i][0] == e.target.name){
					mc.toolOnLane[i][0] = -1;
				}				
			}
			
			
			if(e.target.name == tmp_name ){
				
				mc.toolNum[Number(tmp_name)][0]   = 0;
				mc.lane.removeChild(tool_mc);
				mc.lane.removeEventListener(MouseEvent.MOUSE_UP, mouseUP);
				mc.hiddenTool();
				
				mc["tool"+ tmp_name] = null;
				mc = null;
				tool_mc = null;
				
				
				
			}
			
			
			
		}

	}
	
}
