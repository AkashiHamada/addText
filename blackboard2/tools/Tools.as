package tools {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	public class Tools extends MovieClip {
			public var mc:MovieClip;
			public var tool_mc:MovieClip;
			private var downTime:Number = 0;// downしたとき
			private var downTool:String = "";// downしたときのツール番号　同じツールかどうかの確認のため
			//private var oldName:String ="";
	
		public function Tools(mc:MovieClip, tool_mc:MovieClip) {
			this.mc = mc;
			this.tool_mc = tool_mc;

			mc.lane.addChild(tool_mc);
			tool_mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDOWN);
			tool_mc.addEventListener(MouseEvent.MOUSE_UP, mouseUP);
			tool_mc.addEventListener(MouseEvent.MOUSE_OUT, mouseOUT);
		
			
			
			
			
			
				var i:uint =0;
			// レール上の順番
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
		
		
		public function remove():void{
			
		}
		
		
		
		
		public function mouseDOWN(e:MouseEvent):void{
			downTool =  e.target.name;
			downTime = getTimer();// ダウンした瞬間
		}
		
		
		public function mouseOUT(e:MouseEvent):void{
			downTool = "-1";
		}
		
		public function mouseUP(e:MouseEvent):void{
			
			// ツール名前が一致
			if(downTool	 == e.target.name && downTool != "-1"){
					var upTime:Number= getTimer();// アップした瞬間
					var tmp_name:String = tool_mc.name;// 一時的な変数
					
				
				
					// 長押しの場合
						if((upTime - downTime) >1200){
							// レーンの番号の削除登録
							var i:uint =0;
							for(i; i<18; i++){
								if(mc.toolOnLane[i][0] == e.target.name){
									mc.toolOnLane[i][0] = -1;
								}				
							}
						
							mc.toolNum[Number(tmp_name)][0]   = 0;
							remove();
							mc.lane.removeChild(tool_mc);
							tool_mc.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDOWN);
							tool_mc.removeEventListener(MouseEvent.MOUSE_UP, mouseUP);
							tool_mc.removeEventListener(MouseEvent.MOUSE_OUT, mouseOUT);
							
							mc.hiddenTool();
									
							mc["tool"+ tmp_name] = null;
							mc = null;
							tool_mc = null;
						
						}else{
						
					// 長押しでない場合　exe()
							
							// panel 削除
						
						
							exe();
							// mc.oldName = e.target.name;	
						}

			}// ツール名前が一致 終わり
		}

	}
}