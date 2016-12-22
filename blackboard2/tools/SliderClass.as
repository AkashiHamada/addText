package tools{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	
	public class SliderClass extends MovieClip {
		private const BAR_X:Number = 200;
		private const BAR_Y:Number = 900;
		private const POINT_X:Number = 250;// 200とする
		private const POINT_Y:Number = 900;
		private const SAMPLE_X:Number = 88;
		private const SAMPLE_Y:Number = 907;
		public var mc:MovieClip;// 赤丸
		public var back_mc:MovieClip;// 背景の緑
		public var lane_mc:MovieClip;//　lane
		private var color:uint = 0;
		private var num:uint = 0; //  呼び出したボタンの数字 コンストラクタの引数をプロパティにせっと

		public var down_bl:Boolean = false;
		
		
		
		//private var color:Number = 0xff0000;
		private var size:Number = 5.0;
		private var sp:Sprite;
		public function SliderClass(arg_mc:MovieClip, num:uint, ...val) {
					lane_mc = arg_mc;
					this.color = val[0];
					this.num = num;
		}
		
		 public function mouseDown(e:MouseEvent):void{
					mc.startDrag(false,new Rectangle(BAR_X,BAR_Y,450,1));
					down_bl = true;
								
		}
		
		
		public function mouseUP(e:MouseEvent):void{
					if(num ==1){
						lane_mc.penWidth = (mc.x -200) / 15;
						
					}
					if(num ==2){
						lane_mc.penAlpha = (mc.x -200) / 450;
						
					}
			
					mc.stopDrag();
					down_bl = false;
					lane_mc.swtchMode("write");
			
		}
		
		
		 public function mouseMove(e:MouseEvent):void{
			 //size_btnを押したとき
			 if(num ==1){
				 
					sp.graphics.clear();
					sp.graphics.lineStyle((mc.x  * 0.05),color);
					sp.graphics.moveTo(0,0)
					sp.graphics.lineTo(30,7);
			 }
			
		}
	
		
		
		public function remove(){
			mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);				
			mc.addEventListener(MouseEvent.MOUSE_UP, mouseUP);
			mc.addEventListener(MouseEvent.MOUSE_OUT,mouseUP);
			mc.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			removeDisplayObject(mc);
			removeDisplayObject(back_mc);
			removeDisplayObject(sp);
			
			mc = null;
			back_mc = null;
			sp = null;
			
		}
		
		public function add(pointerX:Number){
			
			// ポインター
			mc = new MyPoint();
			mc.x=pointerX;
			mc.y = POINT_Y; 
			
			// バー
			back_mc = new Bar();
			back_mc.x =BAR_X;
			back_mc.y = BAR_Y;
	
	
			// サンプル
			sp = new Sprite();
			sp.x = SAMPLE_X;
			sp.y  =SAMPLE_Y;
			sp.graphics.lineStyle(size, color);
			sp.graphics.moveTo(0,0)
			sp.graphics.lineTo(30,7);
			
			lane_mc.addChild(back_mc);
			lane_mc.addChild(mc);
			lane_mc.addChild(sp);

			mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);				
			mc.addEventListener(MouseEvent.MOUSE_UP, mouseUP);
			mc.addEventListener(MouseEvent.MOUSE_OUT,mouseUP);
			mc.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
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
		
		
		

	}
	
}
