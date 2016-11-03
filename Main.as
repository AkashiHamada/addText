package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import tools.*;
	
	public class Main extends MovieClip {
		private var	drawer_btn_bl:Boolean = false;//  引き出しのボタンを押したときの切り替え　初期値　引けだしが表示されない
		//private var lane:MovieClip;// lane
		// tool
		public var tool1:MovieClip;
		public var tool2:MovieClip;
		public var tool3:MovieClip;
		public var tool4:MovieClip;
		public var tool5:MovieClip;
		public var cover_mc:MovieClip;
		
		// tool Array
		private var _toolNum:Array = [    //  1番目 : 0の場合は引き出し、１の場合はレールの上
										//  2番目 : X座標
										//  3番目 : Y座標
										[3, 0, 0],// 0番目のツールはなし
										[0, 80, 200],// 1
										[0, 160, 200],//2
										[0, 240, 200],//3
										[0, 320, 200],//4
										[0, 400, 200],//5
										[0, 480, 200],//6
										[0, 560, 200],//7
		
										[0, 80, 300],// 8
										[0, 160, 300],//9
										[0, 240, 300],//10
										[0, 320, 300],//11
										[0, 400, 300],//12
										[0, 480, 300],//13
										[0, 560, 300],//14
		
										[0, 80, 400],// 15
										[0, 160, 400],//16
										[0, 240, 400],//17
										[0, 320, 400],//18
										[0, 400, 400],//19
										[0, 480, 400],//20
										[0, 560, 400],//21
									
										
									];
									
		private var drawer:MovieClip; // 引き出しのパネル
		

		
		public function Main() {
			drawer = new Drawer();
			cover_mc = new MovieClip();
		
			
			drawer.addChild(cover_mc);
			
				
			drawer.addEventListener(MouseEvent.MOUSE_UP, drawerToolUP);//引き出しの中のツールボタンのリスナ
			drawer_btn.addEventListener(MouseEvent.MOUSE_UP, drawer_btnUP);// 引き出しボタンのリスナ
		}
		
		
		
		
		
		// 引き出しの中のツールボタンを離した時
		public function drawerToolUP(e:MouseEvent):void{
			var findToolNum:uint;// forを回して見つけ出したツール番号
			var X:Number = Math.floor(mouseX/80) * 80;
			var Y:Number;
			if(mouseY - (Math.floor(mouseY/100) * 100) < 80){
				Y = Math.floor(mouseY/100) * 100;
			}
			
			//  座標から、ツール番号をだす
			var i:uint =0;
			for(i; i <= 21; i++){
				var j:uint =0;
				for(j; j<3; j++){
					if(j == 1 && _toolNum[i][j] == X && _toolNum[i][2] == Y && _toolNum[i][0] == 0){
						findToolNum = i; // ツール番号を入れる
						_toolNum[i][0] = 1;// ツールがレールに移る
					}
					
				
				}
			}
			
		 // ツールのインスタンスを作る
			switch(findToolNum){
				case 1: tool1 =  new Pen1(this, new TestTool());
					
						
						break;
				case 2:tool2 = new Pen2(this, new TestTool());
				
					
						;break;
				case 3: tool3 = new Pen3(this, new TestTool());break;
				case 4:tool4 = new Pen4(this, new TestTool());break;
				case 5: tool5 =new Pen5(this, new TestTool());break;
			}
			
			
			hiddenTool();
			
			
			
			
			
			
			
			
		}
		
		public function hiddenTool(){
			cover_mc.graphics.clear();
			
			var i:uint =0;
		    for(i; i <= 21; i++){
				
				if(_toolNum[i][0] ==1){
					var j:uint =1;
					for(j; j<3; j++){
						cover_mc.graphics.beginFill(0x444444, 1.0);
						cover_mc.graphics.drawRect(_toolNum[i][1],_toolNum[i][2],80,80);
						cover_mc.graphics.endFill();
					}
				}
				
			}
		}
		
		
		
		// 引き出しボタンを離したとき
		public function drawer_btnUP(e:MouseEvent):void{
			if(drawer_btn_bl){
				drawer_btn_bl= false;
				removeChild(drawer);
			}else{
				drawer_btn_bl= true;
					// 引き出しのパネル 
			
				addChild(drawer);
				setChildIndex(drawer_btn, numChildren -1);
					
			}
			
		}
		
		
		
		
		
		//セッター　ゲッター
		
		public function set toolNum(array:Array){
			_toolNum = array;
		}
		public function get toolNum():Array{
			return _toolNum;
		}
		
		
	
		
		
	}
	
}