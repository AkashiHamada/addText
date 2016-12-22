package{
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.BlendMode;
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
	
	public class Main extends MovieClip{
		
		private const KEEP_BITMAP_DATA:int  =30;// bitmapData の保存の数
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
	//	public var oldName:String ="";// ツールを切り替えたとき、前のツールの終了処理のため。tool.as　長押しでない場合に使用。
		
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
		// ホワイトボード上のむーび―クリップ３０
		public var select_movieClip:String = "parent_sp";//移動ツールで 選択したオブジェクト
		private var old_select_movieClip:String = "parent_sp";
		private var remove_panel:Boolean = false;// panelを削除したかどうか？
		public var movieClip:MovieClip;
		public var movieClip_arr:Array = new Array();// mcを入れる
		private var movieClip_num:uint = 0;
		
		public var bitmap:Bitmap;
		private var _bitmapData:BitmapData;//今使っているビットマップデータ
		public var bitmapData_cnt:int = 0; //ビットマップデータのカウンター
		public var bitmapData_arr:Array = new Array();// ビットマップデータを格納する配列
		private var bitmapDataTool_cnt:int = 0; //ビットマップデータ(tool)のカウンター
		private var bitmapDataTool_arr:Array = new Array();// ビットマップデータ(tool)を格納する配列
		public var createFirst:Boolean = false// 初めて、ビットマップデータ(tool)に格納？ // allEraseで値を入れる
		public var loaderClass:LoaderClass;
		public var mode:String = "move";
		public var grandparents_sp:Sprite;//　parent_spの親　 重なり順が０　基本のスプライト
		public var parent_sp:Sprite;// grandparents_sp の子
	//	public var over_sp:Sprite;
		private var write_sp:Sprite;// 書くときのパネル
		private var panel_sp:Sprite;// scale のときの補助パネル
		
		public var oldMode:String = "";// ひとつ前のモード　 **** toolからアクセス　toolを消したときの不具合
		private var startX:Number =0;
		private var startY:Number   =0;
		
		public var penWidth:Number = 3.0;
		public var penColor:uint = 0x555555;
	    public var penAlpha = 1.0;
		
		private var rotation_rate:Number =0;
		private var loader_width:Number;
		private var loader_height:Number;
		public function Main() {
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT
			stage.scaleMode = "exactFit";
			
			bitmap = new Bitmap();
			bitmap.smoothing = true;
			drawer = new Drawer();
			cover_mc = new MovieClip();
		
			
		
			drawer.addEventListener(MouseEvent.MOUSE_DOWN, drawerToolDOWN);//("引き出しの中")のツールボタンのリスナ
			drawer.addEventListener(MouseEvent.MOUSE_UP, drawerToolUP);//("引き出しの中")のツールボタンのリスナ
			drawer_btn.addEventListener(MouseEvent.MOUSE_UP, drawer_btnUP);// ("引き出しボタン")のリスナ
			move_btn.addEventListener(MouseEvent.MOUSE_DOWN, ChangeMode);
			rotate_btn.addEventListener(MouseEvent.MOUSE_DOWN, ChangeMode);
			scale_btn.addEventListener(MouseEvent.MOUSE_DOWN, ChangeMode);
			
			
			grandparents_sp = new Sprite();	
			parent_sp = new Sprite();
		
			
			
			/* over_sp= new Sprite();
			over_sp.width = 720;
			over_sp.height  = 950*/;
			parent_sp.name = "parent_sp";
			
			drawer.addChild(cover_mc);
			parent_sp.addChild(bitmap);
			grandparents_sp.addChild(parent_sp);
			stage.addChildAt(grandparents_sp,0);
			
			startScreen();
			swtchMode(mode);
		}
		
		//　（start画面）
		public function startScreen(){
			loaderClass = new LoaderClass(this);
				
			start_sp = new Sprite();
			start_sp.graphics.beginFill(0x009900,1.0);
			start_sp.graphics.drawRect(0,0,720, 1280);
			cameraRoll_btn = new ImageI();
			cameraRoll_btn.addEventListener(MouseEvent.CLICK, loaderClass.cameraRoll_click);
			cameraRoll_btn.x = 300;
			cameraRoll_btn.y = 600;
			
			
			
		
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
					 loader_width = loader.width;
					 loader_height= loader.height;
					var rate:Number = 0;
					
					var matrix = new Matrix();
						rate =  950/loader_height;
					//if(loader_width > loader_height){
					//	
					//	matrix.rotate(Math.PI / 180 * 90);
					//	matrix.translate(loader_height,0);
					//	//matrix.scale(720/loader_height, 720/loader_height);
					//	
					//	rate =  1280/loader_width;
					//}else{
					//	rate =  950/loader_height;
					//}
					
							// スマホだけの場合　if(CameraRoll.supportsBrowseForImage){
							//
							
						_bitmapData = new BitmapData(loader_width, loader_height, true, 0xffffffff);
						bitmapData_arr.push(_bitmapData);//ビットマップを格納
						createBitmapData(loader, matrix);
						trace("createBitmapData");
								
								//bitmap.scaleX = rate;
								//bitmap.scaleY = rate;
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
		
		public function ChangeMode(e:MouseEvent):void{
			switch(e.target.name){
					case "move_btn":swtchMode("move");break;
					case "rotate_btn":swtchMode("rotate") ;break;
					case "scale_btn":swtchMode("scale") ;break;
			}
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
								case 1: tool1 =  new Pen1(this, new Write());
										break;
								case 2:tool2 = new SaveClass(this, new Save());
										;break;
								//case 3: tool3 = new MoveClass(this, new Move());break;
								//case 4:tool4 = new ScaleClass(this, new Scale());break;
								//case 5: tool5 =new RotationClass(this, new Rotation());break;
								case 6: tool6 =new Undo(this, new UndoI());break;
								case 7: tool7 =new Redo(this, new RedoI());break;
								case 8: tool8 =new EX(this, new TestTool());break;
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
			
			//  over_spをとりあえず削除
		/*	if(stage.contains(over_sp)){
						stage.removeChild(over_sp);
			}*/
			
			// panel　削除
			
			if(!remove_panel){
				switch(select_movieClip.substr(0,2)){
								case "sp" : trace("sp sp sp sp ");
											if(Boolean(lane.getChildByName("8"))){
												tool8.remove();
												remove_panel = true;
											}; break;
				}
			}
			
			
			
			//  ジェスチャー切り替え
			switch(md){
				case "scale": Multitouch.inputMode = MultitouchInputMode.GESTURE;	
								break;
				case "rotate": Multitouch.inputMode = MultitouchInputMode.GESTURE;
								break;
				default: Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
				         
			}
			
			
								
						
			//  リスナを削除する
			switch(oldMode){
				case "move":  // オブジェトを選択　ト　移動
					           //parent_sp.hasEventListener(TouchEvent.TOUCH_BEGIN); // リスナの登録を確認する場合
				                parent_sp.removeEventListener(TouchEvent.TOUCH_BEGIN, touchBegin );
								parent_sp.removeEventListener(TouchEvent.TOUCH_END, touchEnd); 
								parent_sp.removeEventListener(TouchEvent.TOUCH_OUT, touchEnd); 
							    break;
				case "scale":
								stage.removeEventListener(TransformGestureEvent.GESTURE_ZOOM,functionZoom);
								this.removeChild(panel_sp);
								panel_sp = null;
								break;
				case "rotate": trace("mode: rotate");
								stage.removeEventListener(TransformGestureEvent.GESTURE_ROTATE, onRotate);
								
								break;
				case "write":   write_sp.removeEventListener(TouchEvent.TOUCH_BEGIN, write_spTouch_begin);
							    write_sp.removeEventListener(TouchEvent.TOUCH_END, write_spTouch_end);
								parent_sp.removeChild(write_sp);
								write_sp = null;
								
								//_bitmapData.draw(write_sp);
								
								break;
				case "else": if(Boolean(lane.getChildByName("8"))){
												tool8.remove();
											}; break;
			}
			
			//  リスナを登録する
			switch(md){
							
				case "move": 	
								//select_movieClip = "parent_sp";
								parent_sp.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin );
								parent_sp.addEventListener(TouchEvent.TOUCH_END, touchEnd); 
								parent_sp.addEventListener(TouchEvent.TOUCH_OUT, touchEnd); 
								 a_txt.text = "移動 \n モード";
							    break;
				case "scale": 	stage.addEventListener(TransformGestureEvent.GESTURE_ZOOM,functionZoom);
								a_txt.text = "拡大・縮小 \n モード";
									
								panel_sp = new Sprite();
								panel_sp.name = "panel_sp";
								panel_sp.graphics.beginFill(0x55ff44, 1.0);
								panel_sp.graphics.drawRect(0,0,280,120);
								panel_sp.graphics.endFill();
								panel_sp.y = 1090;
								panel_sp.x = 360;
								this.addChild(panel_sp);
								break;
				case "rotate": stage.addEventListener(TransformGestureEvent.GESTURE_ROTATE, onRotate);
								a_txt.text = "ローテーション　\n モード";
								break;
				case "write":  
								write_sp = new Sprite();
								//write_sp.blendMode = "erase";
								write_sp.graphics.beginFill(0xffffff, 0.01);
								write_sp.graphics.drawRect(0, 0,loader_width, loader_height);
								write_sp.graphics.lineStyle(penWidth,penColor, penAlpha);
								write_sp.graphics.endFill();
								write_sp.addEventListener(TouchEvent.TOUCH_BEGIN, write_spTouch_begin);
								write_sp.addEventListener(TouchEvent.TOUCH_END, write_spTouch_end);
								parent_sp.addChild(write_sp);
								a_txt.text = "書き込み \n モード";
				
								
								break;
				case "else":
					
				
				
				
				
				////////////////test/////////test
								var i:int;
 
//ステージ上の全MovieClip数を取得
var numMc:int = parent_sp.numChildren - 1;
 
//ステージ上の全MovieClipのインスタンス名を取得
for(i = 0;i <= numMc; i++){
     
    //MovieClipを代入
    var mc:DisplayObject =  parent_sp.getChildAt(i);
 
    //MovieClipのインスタンス名を取得
    var mcName:String = mc.name;
     
    trace("name" + [i] + ":" + mcName);
}
/// test            ///////////////test

								a_txt.text = "普通 \n モード";
								
				
			}
			trace("oldMode:" + oldMode);
			oldMode = md;
		}
		
		
		
		
		
		// リスナー関数
		public function touchBegin(e:TouchEvent):void{
			select_movieClip = e.target.name;
			
			switch(old_select_movieClip.substr(0,2)){
				case "sp" :if(Boolean(lane.getChildByName("8"))){
												tool8.remove();
												remove_panel = true;
											}
							;break;
			}
			
			
			switch(e.target.name){
				case "parent_sp": parent_sp.startTouchDrag(e.touchPointID, false, new Rectangle(-1000,-1000,2000,2000));break;
				default  : for(var i:uint=0; i<movieClip_arr.length; i++){
								if(e.target.name == movieClip_arr[i].name){
									var tmp_mc:MovieClip = MovieClip(movieClip_arr[i]);
									grandparents_sp.setChildIndex(tmp_mc,stage.numChildren-1);
									tmp_mc.startTouchDrag(e.touchPointID, false, new Rectangle(-30,-30,700,900));
								}
							}
						
								// パネル追加
							if(select_movieClip.substr(0,2) == "sp"){
								if(Boolean(lane.getChildByName("8"))){
									tool8.panel();
									remove_panel = false;
								}
					
							}
								
				
			}
			old_select_movieClip = select_movieClip;
			
		}
		 public function touchEnd(e:TouchEvent):void{
			
			 select_movieClip = e.target.name;
			 remove_panel = false;
		
			 switch(e.target.name){
				case "parent_sp": parent_sp.stopTouchDrag(e.touchPointID);break;
									
				default  : for(var i:uint=0; i<movieClip_arr.length; i++){
								if(e.target.name == movieClip_arr[i].name){
								MovieClip(movieClip_arr[i]).stopTouchDrag(e.touchPointID);
									
								
							
								}
							}
							
							
			}
			
			
		}
		
		private function onRotate(e:TransformGestureEvent):void
		{
			
			
			if(select_movieClip == "parent_sp"){
					rotation_rate += e.rotation;
			
					//  4 
					
					/*if(rotation_rate < -180){
						rotation_rate= 0;
					}else if(rotation_rate < -135){
						parent_sp.rotation = 180;
						rotation_rate= 0;
						
					}else */if(rotation_rate < -45){
						//parent_sp.rotation = -90;
						parent_sp.rotation -= 90;
						rotation_rate =0;
					}
					
					if(rotation_rate > 45){
						//parent_sp.rotation = 90;
						parent_sp.rotation += 90;
						rotation_rate =0;
					}/*else if(rotation_rate < 135){
						parent_sp.rotation = 90;
						rotation_rate= 0;
						
						
					}else{
						parent_sp.rotation = 180;
						
						rotation_rate= 0;
					}
					*/
					
						if(parent_sp.rotation  < -135){
				
							parent_sp.x = loader_width;
							parent_sp.y  = loader_height;
							
						}else if(parent_sp.rotation < -45){
						
							parent_sp.x =0;
							parent_sp.y  = loader_width;
						}else if(parent_sp.rotation < 45){
							
							parent_sp.x = 0;
							parent_sp.y  = 0;
						}else if(parent_sp.rotation  < 135){
						
							parent_sp.x = loader_height;
							parent_sp.y =0;
							
						}else{
						
							parent_sp.x = loader_width;
							parent_sp.y  = loader_height;
							
						}
			}else{
					for(var i:uint=0; i<movieClip_arr.length; i++){
							if(select_movieClip == movieClip_arr[i].name){
								rotateAroundCenter(MovieClip(movieClip_arr[i]),e.rotation);
							}
					}
		
			}
	
		}
		
		
		
		
		private function functionZoom(e:TransformGestureEvent):void{
			if(select_movieClip == "parent_sp"){
				if(parent_sp.scaleX >0.03){
						parent_sp.scaleX *= (e.scaleX + e.scaleY)/2;
						parent_sp.scaleY *= (e.scaleX + e.scaleY)/2;
				}else{
					if((e.scaleX + e.scaleY)/2 >1){
						parent_sp.scaleX *= (e.scaleX + e.scaleY)/2;
						parent_sp.scaleY *= (e.scaleX + e.scaleY)/2;
					}
				}
			}else{
					for(var i:uint=0; i<movieClip_arr.length; i++){
							if(select_movieClip == movieClip_arr[i].name){
					
								if(MovieClip(movieClip_arr[i]).scaleX >0.03){
									MovieClip(movieClip_arr[i]).scaleX *= (e.scaleX + e.scaleY)/2 ;
									MovieClip(movieClip_arr[i]).scaleY *= (e.scaleX + e.scaleY)/2;
								}else{
									if((e.scaleX + e.scaleY)/2 >1){
										MovieClip(movieClip_arr[i]).scaleX *= (e.scaleX + e.scaleY)/2 ;
										MovieClip(movieClip_arr[i]).scaleY *= (e.scaleX + e.scaleY)/2;
									}
								}
							
							}
					}
			}			
			
			
			//// ヨコ
			//if(parent_sp.scaleX >0.03){
			//	parent_sp.scaleX *= (e.scaleX + e.scaleY)/2 ;
			//}else{
			//	if((e.scaleX + e.scaleY)/2 >1){
			//		parent_sp.scaleX *= (e.scaleX + e.scaleY)/2 ;
			//	}
			//}
			//
			//// 縦
			//if(parent_sp.scaleY >0.03){
			//	parent_sp.scaleY *= (e.scaleX + e.scaleY)/2 ;
			//}else{
			//	if((e.scaleX + e.scaleY)/2 >1){
			//		parent_sp.scaleY *= (e.scaleX + e.scaleY)/2 ;
			//	}
			//}
			

		}
		
		
		 public function write_spTouch_begin(e:TouchEvent){
			 trace("bitmapdata_cnt::" + bitmapData_cnt);
	
			startX = e.localX;
			startY = e.localY;
		  　write_sp.graphics.moveTo(startX, startY);
			write_sp.addEventListener(TouchEvent.TOUCH_MOVE, write_spTouch_move);
			 // tool1.cp1.open();
		}
		 public function write_spTouch_end(e:TouchEvent){
			 
	
			createBitmapData(write_sp,null,"write");
			//bitmapData.draw(write_sp); // bitmapData に書き込み
			write_sp.removeEventListener(TouchEvent.TOUCH_MOVE, write_spTouch_move);
			 write_sp.graphics.clear();
			 write_sp.graphics.beginFill(0xffffff, 0.01);
								write_sp.graphics.drawRect(0, 0,loader_width, loader_height);
								write_sp.graphics.lineStyle(penWidth,penColor, penAlpha);
								write_sp.graphics.endFill();
			 //tool1.cp1.open();
	   }
	   public function write_spTouch_move(e:TouchEvent):void{
		  
		　　write_sp.graphics.lineTo(e.localX, e.localY);
		　　startX = e.localX;
			startY = e.localY;
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
		
		
		
		
		
		
		
		// 30個のオブジェクト
		public function createMovieClip(mc){
			
			mc.name = mc.name + (movieClip_num++);
			mc.x += 100 * movieClip_num;
		
			MovieClip(mc).addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin );
			MovieClip(mc).addEventListener(TouchEvent.TOUCH_END, touchEnd); 
			MovieClip(mc).addEventListener(TouchEvent.TOUCH_OUT, touchEnd); 
			grandparents_sp.addChild(mc);
		
			movieClip_arr.push(mc);
			
		}
		
		public function removeMC(nameMC){
				//　名前から探して、りすな削除
			for(var i:uint=0; i<movieClip_arr.length; i++){
				if(nameMC == movieClip_arr[i].name){
					movieClip_arr[i].removeEventListener(TouchEvent.TOUCH_BEGIN, touchBegin );
					movieClip_arr[i].removeEventListener(TouchEvent.TOUCH_END, touchEnd);
					movieClip_arr[i].removeEventListener(TouchEvent.TOUCH_OUT, touchEnd);
					grandparents_sp.removeChild(movieClip_arr[i]);
					movieClip_arr.splice(i,1);
				}
			}
			
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
		
		
		
		
		
		
		// ビットマップデータ　作成　　引数１：オブジェクト、２：マトリックス　３：
		public function createBitmapData(obj:DisplayObject, ...val){
			// 共通
			if(bitmapData_arr.length > bitmapData_cnt +1){
						trace("in");
						bitmapData_arr.splice(bitmapData_cnt + 1,bitmapData_arr.length-bitmapData_cnt);
					}
				
					 var _bitmapData_tmp:BitmapData =  BitmapData(bitmapData_arr[bitmapData_cnt]).clone();
						_bitmapData_tmp.lock();
					
					// matrixがある場合とない場合
					if(val[0]){
						_bitmapData_tmp.draw(obj,val[0]);
					}else{
						trace("not matrix");
						//_bitmapData_tmp.draw(obj,null,null,BlendMode.ERASE);
						_bitmapData_tmp.draw(obj);
					}
					_bitmapData_tmp.unlock();
			
			// (tool)内でのビットマップ
			if(val[1]){
				
			
				if(bitmapDataTool_cnt >KEEP_BITMAP_DATA){
						
						
							bitmapDataTool_arr.shift();//ビットマップを格納
							bitmapDataTool_arr.push(_bitmapData_tmp);//ビットマップを格納
							//parent_sp.removeChild(bitmap);
							bitmap.bitmapData = bitmapDataTool_arr[bitmapDataTool_cnt];// ビットマップをすり替える。
							//parent_sp.addChild(bitmap);
					}else{
						
							bitmapDataTool_cnt++;
							bitmapDataTool_arr.push(_bitmapData_tmp);//ビットマップを格納
							//parent_sp.removeChild(bitmap);
							bitmap.bitmapData = _bitmapData_tmp;// ビットマップをすり替える。
						
							//parent_sp.addChild(bitmap);
						
					}
					// 上の配列に入れる
					if(!createFirst) {
						bitmapData_cnt++;
						createFirst = true;
					}
					bitmapData_arr[bitmapData_cnt] = _bitmapData_tmp;
			}else{ //　通常時
				// 配列の要素数とカウンターの数より多い時、
					
					

					if(bitmapData_cnt >KEEP_BITMAP_DATA){
						
						
							bitmapData_arr.shift();//ビットマップを格納
							bitmapData_arr.push(_bitmapData);//ビットマップを格納
							//parent_sp.removeChild(bitmap);
							bitmap.bitmapData = bitmapData_arr[bitmapData_cnt];// ビットマップをすり替える。
							//parent_sp.addChild(bitmap);
					}else{
						
						trace("bitmapdata_cnt::" + bitmapData_cnt);
							bitmapData_cnt++;
							bitmapData_arr.push(_bitmapData_tmp);//ビットマップを格納
							//parent_sp.removeChild(bitmap);
							bitmap.bitmapData = _bitmapData_tmp;// ビットマップをすり替える。
						
							//parent_sp.addChild(bitmap);
						
					}
					
					
					
			}
			
			
					
					
			
		}
		// tool使用時、全削除
		public function allErase(){
			bitmapData_cnt--;
			bitmapData_arr.pop();
			bitmap.bitmapData = bitmapData_arr[bitmapData_cnt];
			createFirst= false;
		}
		
		public function set bitmapData(bitmapData:BitmapData){
			_bitmapData = bitmapData;
		}
		public function get bitmapData():BitmapData{
			return _bitmapData;
		}
	}
}
