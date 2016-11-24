package{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import tools.*;
	import flash.display.Sprite;
	
	// カメラ
	import flash.media.CameraRoll;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MediaEvent;
	import flash.media.MediaPromise;

	//import flash.display.LoaderInfo;
	import flash.text.TextField;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	
	
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
    import flash.events.TouchEvent;
	 import flash.events.GestureEvent;
	 import flash.events.TransformGestureEvent;



	public class Main extends MovieClip {
		private var	drawer_btn_bl:Boolean = false;//  引き出しのボタンを押したときの切り替え　初期値　引けだしが表示されない
		// tool
		public var tool1:MovieClip;
		public var tool2:MovieClip;
		public var tool3:MovieClip;
		public var tool4:MovieClip;
		public var tool5:MovieClip;
		public var tool6:MovieClip;
		public var tool7:MovieClip;
		public var tool8:MovieClip;
		public var tool9:MovieClip;
		public var tool10:MovieClip;
		public var tool11:MovieClip;
		public var tool12:MovieClip;
		public var tool13:MovieClip;
		public var tool14:MovieClip;
		public var tool15:MovieClip;
		public var tool16:MovieClip;
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
									
		public var toolOnLane:Array = [　　// 1番目　使われていない？
											//  2番目 : X座標
											//  3番目 : Y座標	
											
											[-1, 0, 950],
											[-1, 80, 950],
											[-1, 160, 950],
											[-1, 240, 950],
											[-1, 320, 950],
											[-1, 400, 950],
											[-1, 480, 950],
											[-1, 560, 950],
											[-1, 640, 950],
											
											
											[-1, 0, 1030],
											[-1, 80, 1030],
											[-1, 160, 1030],
											[-1, 240, 1030],
											[-1, 320, 1030],
											[-1, 400, 1030],
											[-1, 480, 1030],
											[-1, 560, 1030],
											[-1, 640, 1030],
									];
		
									
		private var drawer:MovieClip; // 引き出しのパネル
		private var downTime:Number = 0;// （”引き出しの中”）でダウンした瞬間
		private var start_sp:Sprite;// （start画面)
		private var cameraRoll_btn:Sprite;//　（start画面)カメラロールのボタン
	
		private var text_field:TextField; // （start画面)てきすと
		
		private var bitmap:Bitmap;
		private var _bitmapData:BitmapData;
		public var loaderClass:LoaderClass;
		public var mode:String = "move";
		
		public var parent_sp:Sprite;
		public var over_sp:Sprite;
		private var guestureMode:Boolean = true;
		private var oldMode:String = "";
		public function Main() {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT
			
			bitmap = new Bitmap();
			drawer = new Drawer();
			cover_mc = new MovieClip();
			
		
			drawer.addEventListener(MouseEvent.MOUSE_DOWN, drawerToolDOWN);//("引き出しの中")のツールボタンのリスナ
			drawer.addEventListener(MouseEvent.MOUSE_UP, drawerToolUP);//("引き出しの中")のツールボタンのリスナ
			drawer_btn.addEventListener(MouseEvent.MOUSE_UP, drawer_btnUP);// ("引き出しボタン")のリスナ
			
			 parent_sp = new Sprite();
			
			
			
			 over_sp= new Sprite();
			over_sp.width = 720;
			over_sp.height  = 950;
					
			drawer.addChild(cover_mc);
			parent_sp.addChild(bitmap);
			stage.addChildAt(parent_sp,0);
			
			
			
			
			
			
			
		
			startScreen();
			swtchMode(mode);
			
		}
		
		//　（start画面）
		public function startScreen(){
		
				
			loaderClass = new LoaderClass(this);
					
			start_sp = new Sprite();
			start_sp.graphics.beginFill(0x009900,1.0);
			start_sp.graphics.drawRect(0,0,720, 1280);
			cameraRoll_btn = new TestTool();
			cameraRoll_btn.addEventListener(MouseEvent.CLICK, loaderClass.cameraRoll_click);
			
				
						// テキストフィールドを作成
			text_field = new TextField();
			text_field.x = 10;
			text_field.y = stage.stageHeight - 200 - 10;
			text_field.width = stage.stageWidth - 20;
			text_field.height = 200;
			text_field.border = true;
			
		
			
			start_sp.addChild(text_field);
			start_sp.addChild(cameraRoll_btn);
				
		    stage.addChild(start_sp);
			
			
			}
			
			//  (start画面)を壊し、　ビットマップにデータを入れる
		public function removeScreen(){
					
					var loader:Loader = loaderClass.loader;
					var loader_width:Number = loader.width;
					var loader_height:Number = loader.height;
					var rate:Number = 0;
					
					var matrix = new Matrix();
					if(loader_width > loader_height){
						
						matrix.rotate(Math.PI / 180 * 90);
						matrix.translate(loader_height,0);
						//matrix.scale(720/loader_height, 720/loader_height);
						
						rate =  1280/loader_width;
					}else{
						rate =  950/loader_height;
					}
					
							// スマホだけの場合　if(CameraRoll.supportsBrowseForImage){
							//
						
								bitmapData = new BitmapData(loader_width, loader_height, true, 0xffffffff);
								bitmapData.draw(loader,matrix);
								bitmap.bitmapData = bitmapData;
								bitmap.scaleX = rate;
								bitmap.scaleY = rate;
							//  
							//
					
						
							
					start_sp.removeChild(text_field);
					start_sp.removeChild(cameraRoll_btn);
					stage.removeChild(start_sp);
				//	stage.removeChild(loader);
					
					
					text_field = null;
					cameraRoll_btn = null;
					start_sp = null;
				
			
			
			
					loaderClass = null;
		}
		
		
		// down
		public function drawerToolDOWN(e:MouseEvent):void{
			downTime = getTimer();// ダウンした瞬間
		}
		
		
		
		
		
		
		// up
		
		// 茶色　(drawer)   のツールボタンを離した時
		public function drawerToolUP(e:MouseEvent):void{
			var upTime:Number= getTimer();// アップした瞬間
			var findToolNum:uint;// forを回して見つけ出したツール番号
			var X:Number = Math.floor(mouseX/80) * 80;
			var Y:Number;
			if(mouseY - (Math.floor(mouseY/100) * 100) < 80){
				Y = Math.floor(mouseY/100) * 100;
			}
			
			
			//  座標から、ツール番号をだす
			var i:uint =1;
			for(i; i <= 20; i++){
				var j:uint =0;
				for(j; j<3; j++){
					if(j == 1 && _toolNum[i][j] == X && _toolNum[i][2] == Y && _toolNum[i][0] == 0){
						findToolNum = i; // ツール番号を入れる
						
					}
					
				
				}
			}
			
			
				// 長押し
				if((upTime - downTime) >1200){
						// ツールのインスタンスを作る
							// ツールが引き出しにある場合
						if(_toolNum[findToolNum][0] ==0){
							switch(findToolNum){
								case 1: tool1 =  new Pen1(this, new TestTool());
									
										
										break;
								case 2:tool2 = new Pen2(this, new TestTool());
										
								
									
										;break;
								case 3: tool3 = new Pen3(this, new TestTool());break;
								case 4:tool4 = new Pen4(this, new TestTool());break;
								case 5: tool5 =new Pen5(this, new TestTool());break;
								case 6: tool6 =new Pen6(this, new TestTool());break;
								case 7: tool7 =new Pen7(this, new TestTool());break;
								case 8: tool8 =new Pen8(this, new TestTool());break;
								case 9: tool9 =new Pen9(this, new TestTool());break;
								case 10: tool10 =new Pen10(this, new TestTool());break;
								case 11: tool10 =new Pen11(this, new TestTool());break;
								case 12: tool12 =new Pen12(this, new TestTool());break;
								case 13: tool13 =new Pen13(this, new TestTool());break;
								case 14: tool14 =new Pen14(this, new TestTool());break;
								case 15: tool15 =new Pen15(this, new TestTool());break;
								case 16: tool16 =new Pen16(this, new TestTool());break;
								//case 9: tool9 =new Pen9(this, new TestTool());break;
							}
						
						
							_toolNum[findToolNum][0] = 1;// ツールをレールに登録
							hiddenTool();// ツールの表示を隠す
						}// end   ツールが引き出しにある場合	
						
				}else{
				// 長押しでない
						
					trace("長押しでない");	
						
				}
		
			}// end     茶色　(drawer)   のツールボタンを離した時
			
			
			
				
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
		// (drawer_btn)  引き出しボタンを離したとき
		public function drawer_btnUP(e:MouseEvent):void{
			if(drawer_btn_bl){
				drawer_btn_bl= false;
				stage.removeChild(drawer);
			}else{
				drawer_btn_bl= true;
					// 引き出しのパネル 
			
				stage.addChild(drawer);
				stage.setChildIndex(drawer, stage.numChildren -1);
				//stage.setChildIndex(drawer_btn, stage.numChildren -1);
					
			}
		}
		public function swtchMode(md:String){
		
			
			//  ジェスチャー切り替え
			switch(md){
				case "move":break;
				default :if(guestureMode){
							stage.addChild(over_sp);
							Multitouch.inputMode = MultitouchInputMode.GESTURE;
							guestureMode = false;
				         }
			}
			
		
			//  リスナを削除する
			switch(oldMode){
				case "move": 	parent_sp.removeEventListener(TouchEvent.TOUCH_BEGIN, touchBegin );
								parent_sp.removeEventListener(TouchEvent.TOUCH_END, touchEnd); 
								
							    break;
				case "scale": 	
								stage.removeEventListener(TransformGestureEvent.GESTURE_ZOOM,functionZoom);
								
								
								break;
				case "rotate": 
								stage.removeEventListener(TransformGestureEvent.GESTURE_ROTATE, onRotate);
						
								break;
			}
			
			//  リスナを登録する
			switch(md){
				case "move": 	removeDisplayObject(over_sp);
								guestureMode = true; 
								Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
					
								parent_sp.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin );
								parent_sp.addEventListener(TouchEvent.TOUCH_END, touchEnd); 
								 
							    break;
				case "scale": 	stage.addEventListener(TransformGestureEvent.GESTURE_ZOOM,functionZoom);
								
								
								break;
				case "rotate": stage.addEventListener(TransformGestureEvent.GESTURE_ROTATE, onRotate);
						
								break;
				
			}
			
			
			oldMode = md;
			
			
		}
		
		// リスナー関数
		public function touchBegin(e:TouchEvent):void{
			parent_sp.startTouchDrag(e.touchPointID, false, new Rectangle(-1000,-1000,2000,2000));
		}
		 public function touchEnd(e:TouchEvent):void{
			parent_sp.stopTouchDrag(e.touchPointID);
		}
		
		private function onRotate(e:TransformGestureEvent):void
		{
			rotateAroundCenter(parent_sp,e.rotation);
		}
		
		private function functionZoom(e:TransformGestureEvent):void{
								parent_sp.scaleX *= e.scaleX;
								parent_sp.scaleY *= e.scaleY;

		}
		
		// center 回転軸を中心にする
		public function rotateAroundCenter(object:DisplayObject, angleDegrees:Number):void {
			if (object.rotation == angleDegrees) {
				return;
			}

			var matrix:Matrix = object.transform.matrix;
			var rect:Rectangle = object.getBounds(object.parent);

			matrix.translate(-(rect.left + (rect.width / 2)), -(rect.top + (rect.height / 2)));
			matrix.rotate((angleDegrees / 180) * Math.PI);
			matrix.translate(rect.left + (rect.width / 2), rect.top + (rect.height / 2));
			object.transform.matrix = matrix;
			object.rotation = Math.round(object.rotation);
		}
		//   remove処理
		public function removeDisplayObject(display_obj:DisplayObject) :Boolean{
			if(display_obj == null){
				
				return false;
			}
			var parent:DisplayObjectContainer = display_obj.parent;
			if(!parent)	return false;
			var obj:DisplayObject =  parent.removeChild(display_obj);
			return (obj == display_obj);
		}
		
		
		
		//セッター　ゲッター
		public function set toolNum(array:Array){
			_toolNum = array;
		}
		public function get toolNum():Array{
			return _toolNum;
		}
		public function set bitmapData(bitmapData:BitmapData){
			_bitmapData = bitmapData;
		}
		public function get bitmapData():BitmapData{
			return _bitmapData;
		}
		
		
	}
}
